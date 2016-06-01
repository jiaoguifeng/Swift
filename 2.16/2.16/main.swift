//
//  main.swift
//  2.16
//
//  Created by jiaoguifeng on 12/26/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 自动引用计数 */
/*
Swift使用自动引用计数(ARC)来跟踪并管理应用使用的内存。大部分情况下，这意味着在Swift语言中，内存管理“仍然工作”，不需要自己去考虑内存管理的事情。当实例不在被使用时，ARC会自动释放这些类的实例所占用的内存。
然后，在少数情况下，为了自动的管理内存空间，ARC需要了解关于你的代码片段之间关系的更多信息。本章描述了这些情况，并向大家展示如何打开ARC来管理应用的所有内存空间。
注意：引用计数值应用在类的实例。结构体(structure)和枚举类型是值类型，并非引用类型，不是以引用的方式来存储和传递的。
*/

//ARC如何工作
class Person
{
    let name: String
    init(name: String)
    {
        self.name = name
        println("\(name) is being initialized")
    }
    
    deinit
    {
        println("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")

reference2 = reference1
reference3 = reference2

reference1 = nil
reference2 = nil
reference3 = nil

//类实例间的强引用环
/*
  上面的例子中，ARC可以追踪Person实例的引用数量，并且在它不在被使用时摧毁这个实例。

  然而，我们有可能会写出这样的代码，一个类的实例永远不会有0个强引用。在两个类实例彼此保持对方的强引用，使得每个实例都使对方保持有效时会发生这种情况。我们称之为强引用环。

  通过用若引用或者无主引用来取代强引用，我们可以解决强引用环问题。

  下面的例子展示了一个强引用环是如何在不经意间产生的。
*/

class Person1
{
    let name: String
    init(name: String)
    {
        self.name = name
        println("\(name) is being initialized")
    }
    
    var apartment: Apartment?
    
    deinit
    {
        println("\(name) is being deinitialized")
    }

}

class Apartment
{
    let number: Int
    init(number: Int)
    {
        self.number = number
        println("\(number) is being initialized")
    }
    
    weak var tenant: Person1?  //引起引用环的是：var tenant: Person1?
    
    deinit
    {
        println("Apartment #\(number) is being deinitialized")
    }
}

var john: Person1?
var number73: Apartment?

john = Person1(name: "John Appleseed")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

john = nil
number73 = nil

/*
注意；当上面两个变量赋值为nil时，没有调用任何一个deinitializer。强引用环阻止了Person和Apartment实例的销毁，进一步导致内存泄露。
*/


//解决强引用环
/*
Swift提供两种方法解决强引用环：弱引用和无主引用

弱引用和无主引用允许引用环中的一个实例引用另一个实例，但不是强引用。因此实例可以相互引用但是不会产生强引用环。

对于声明周期中引用会变为nil的实例，使用弱引用，对于初始化时赋值之后引起再也不会赋值为nil的实例，使用无主引用。

**弱引用**：
弱引用不会增加实例的引用计数，因此不会阻止ARC销毁被引用的实例。这种特性使得引用不会变成强引用环。声明属性或者变量的时候，关键字weak表明引用为弱引用

在实例的生命周期中，如果某些时候没有引用值，那么弱引用可以阻止强引用环。
注意：弱引用只能声明为变量类型，因为运行时它的值可能该表。弱引用绝对不能声明为常量。
因为弱引用可以没有值，所以声明弱引用的时候必须是可选类型的。在Swift语言中，推荐用可选类型来作为可能没有值的引用的类型

直接在上面的例子修改

**无主引用**
和弱引用相似，无主引用也不强持有实例。但是和弱引用不同的是，无主引用默认始终有值。因此，无主引用只能定义为非可选类型(non-optionaltype)。在属性、变量前添加unowned关键字，可以声明一个无主引用。

因为是非可选类型，因此当使用无主引用的时候，不需要展开，可以直接访问。不过非可选类型变量不能赋值为nil，因此当实例被销毁的时候，ARC无法将引用赋值为nil
注意：当实例被销毁后，试图访问该实例的无主引用会触发运行时错误。使用无主引用时请确保引用始终指向一个未销毁的实例。上面的非法操作会百分百让应用崩溃，不会发生无法预期的行为。因此，你应该避免这种情况。
*/

//无主引用实例
class Customer
{
    let name: String
    var card: CreditCard?
    
    init(name: String)
    {
        self.name = name
    }
    
    deinit
    {
        println("\(name) is being deinitialized")
    }
}

class CreditCard
{
    let number: Int
    unowned let customer: Customer
    init(number: Int,customer: Customer)
    {
        self.number = number
        self.customer = customer
    }
    
    deinit
    {
        println("Card #\(number) is being deinitialized")
    }
}

var jiao: Customer?
jiao = Customer(name: "jiaoguifeng")
jiao!.card = CreditCard(number: 1234_5678_9012_3456, customer: jiao!)

jiao = nil

//无主引用以及隐式展开的可选属性
/*
Person和Apartment的例子说明了下面的场景：两个属性都有可能是nil，并有可能产生强引用环，这种场景下适合使用弱引用。

Customer和CreditCard的例子说明了另外的场景：一个属于nil，另外一个属性不允许是nil，并有可能产生强引用环。这样的场景适合使用无主引用。

但是，存在第三种场景：两个属性都必须有值，且初始化完成后不能为nil。这种场景下，则要一个类用无主引用属性，另一个类用隐式展开的可选属性。
*/

class Country
{
    let name: String
    let capitalCity: City!   //声明Country的capitalCity属性为隐式展开的可选类型属性。也就是说，capitalCity属性的默认值是nil，不需要展开它的值就可以直接访问
    init(name: String, capitalName: String)
    {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City
{
    let name: String
    unowned let country: Country
    init(name: String, country: Country)
    {
        self.name = name
        self.country = country
    }
}

//因为capitalCity默认值为nil，一旦Country的实例在初始化时给name赋值后，整个初始化过程就完成了。这代表只要赋值name属性后，Country的初始化函数就能引用并传递隐式的self。当Country的初始化函数在赋值capitalCity时，它也可以将self作为参数传递给City的初始化函数

var country = Country(name: "Canada", capitalName: "Ottawa")
println("\(country.name)'s captial city is called \(country.capitalCity.name)")

//闭包产生的强引用环

class HTMLElement
{
    let name: String
    let text: String?
    
    lazy var asHTML:() -> String = {
        
        [unowned self] in           //解决闭包强引用环问题，引起强引用环时没有这一句
        if let text = self.text
        {
            return "<\(self.name)>\(text)</\(self.name)>"
        }
        else
        {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil)
    {
        self.name = name
        self.text = text
    }
    
    deinit
    {
        println("\(name) is being deinitialized")
    }
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello world")
println(paragraph!.asHTML())

paragraph = nil

//解决闭包产生的强引用环












