//
//  main.swift
//  2.14
//
//  Created by jiaoguifeng on 12/24/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 构造过程 */
/*
    构造过程是为了使用某一个类、结构体或者枚举类型的实例而进行的准备过程，这个过程包括了为实例中的每一个属性设置初始值和为其执行必要的准备和初始化任务。
    构造过程是通过定义构造器(initializers)来实现的，这种构造器可以看做是用来创建特定类型实例的特殊方法。与objective-c中的构造器不同，swift的构造器无需返回值，他们的主要任务是保证新实例在第一次使用前正确的初始化
    类实例也可以通过定义析构器(deinitializer)在类实例释放之前执行特定的清除工作。
*/

//存储型属性的初始赋值
/*
  类和结构体在实例创建时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态
  你可以在构造器中为存储型属性赋初值，也可以在定义属性的时候为其设置初始值。
  注意：当你为存储型属性设置默认值或者在构造器中为其赋值时，他们的值是被直接设置的，不会触发任何属性观测器(property observers)。
*/

//构造器
 //构造器在创建某特定类型的新实例时调用，它的最简单的形式类似于一个不带任何参数的实例方法，以关键字init命名。

struct Fahrenheit
{
    var temperature: Double
    init() //这个结构体定义了一个不带参数的构造器init，并且里面将存储器属性temperature的值初始化为32.0
    {
        temperature = 32.0
    }
}

var f = Fahrenheit()
println("The default temperature is \(f.temperature) Fahrenheit")

//定制化构造过程
/*
你可以通过输入参数和可选属性类型来定制构造过程，也可以在构造过程中修改变量属性
*/

//构造参数
struct Celsius
{
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double)
    {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double)
    {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)

let freezingPointOfWater = Celsius(fromKelvin: 273.15)

//内部和外部参数名
/*
跟函数和方法的参数相同，构造参数也存在一个在构造器内部使用的参数名称和一个在调用构造器时使用的外部参数名称。
然而，构造器并不像函数和方法那样在括号前有一个可辨识的名字，所在在调用构造器时，主要通过构造器中的参数名和类型来确定需要调用的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名字，Swift会为每个构造器的参数自动生成一个跟内部名字相同的外部名，就相当于在每个构造参数之前加了一个哈希符号

注意：如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线_来显示描述它的外部名，以此覆盖上面所说的默认行为。
*/

struct Color
{
    let red = 0.0, green = 0.0, blue = 0.0
    init(red: Double, green: Double, blue: Double)
    {
        self.red = red
        self.green = green
        self.blue = blue  //? 为啥可以修改常量(let)？
        
        //可以在构造过程中修改。。。
    }
    
    init(white: Double)
    {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)

let halfGray = Color(white: 0.5)

//可选属性类型
/*
如果你定制的类型包括一个逻辑上允许取值为空的存储型属性--不管是因为他无法在初始化赋值，还是因为他可以在之后某个时间点可以赋值为空--你都可以将它定义为可选类型optional type。可选类型的属性将自动初始化为空nil，表示这个属性是故意在初始化时设置为空的。
*/

class SurveyQuestion
{
    var text: String
    var response: String?
    init(text: String)
    {
        self.text = text
    }
    
    func ask()
    {
        println(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()

println(cheeseQuestion.response)
cheeseQuestion.response = "Yes, I do like cheese."
println(cheeseQuestion.response)

//构造过程中常量属性的修改
/*
   只要在构造过程结束前常量的值能确定，你可以在构造过程中的任意时间点修改常量属性的值。
   注意：对某个类实例来讲，它的常量属性只能在定义它的构造过程中修改，不能在子类中修改。
*/

//默认构造器
/*
Swift将为所有属性已提供默认值且自身没有定义任何构造器的结构体或基类，提供一个默认的构造器。这个默认构造器将简单的创建一个所有属性值都设置为默认值的实例
*/
class ShoppingListItem
{
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem()

//结构体的逐一成员构造器
/*
  除上面提到的默认构造器，如果结构体对所有存储型属性提供了默认值且自身没有提供特定的构造器，他们能自动获得一个逐一成员构造器
  逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方式。我们在调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的厨师赋值
*/

struct Size_
{
    var width = 0.0, height = 0.0
}
let twoByTwo = Size_(width: 2.0, height: 2.0)

//值类型的构造器代理
/*
   构造器可以通过调用其他构造器来完成实例的部分构造过程。这一过程称之为构造器代理，它能减少多个构造器间的代码重复。
   构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型(结构体和枚举类型)不支持继承，所以构造器代理的过程相对简单，因为他们只能代理任务给本身提供其他构造器。类则不同，它可以继承自其他类，这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。
   对于值类型，你可以使用self.init在自定义的构造器中引用其他的属于相同值类型的构造器，并且你只能在构造器内部调用self.init

注意：如果你为某个值类型定义了一个定制的构造器，你将无法访问到默认构造器(如果是结构体，则无法访问逐一对象构造器)。这个限制可以防止你在为值类型定义了一个更复杂的，完成了重要准备构造器之后，别人还是错位的使用了那个自动生成的构造器。
注意：如果你相想通过默认构造器、逐一对象构造器以及你自己定制的构造器为值类型构造实例，我们建议你将自己定制的构造体写到扩展(extension)中，而不是跟值类型定义混在一起。
*/

struct Size
{
    var width = 0.0, height = 0.0
}
struct Point
{
    var x = 0.0, y = 0.0
}

struct Rect
{
    var origin = Point()
    var size = Size()
    init()
    {
        
    }
    init(origin: Point, size: Size)
    {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size)
    {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY),size: size) //代理
    }
}

let basicRect = Rect()
//basicRect的原点是(0.0,0.0),尺寸是(0.0,0.0)
println(basicRect.size.width)

let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
//originRect的原点是(2.0,2.0),尺寸是(5.0,5.0)

/*
第三个Rect构造器init(center:size:)稍微复杂一点。它先通过center和size计算出origin的坐标。然后再调用(或代理给)init(origin: Point, size: Size)构造器来将新的origin和size值赋值到对应的属性中
*/
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
//centerRect的原点是(2.5,2.5),尺寸是(3.0,3.0)

//类的继承和构造过程
/*
  类里面的所有存储型属性--包括所有继承自父类的属性--都需要在构造过程中设置初始值
  Swift提供了两种类型的类构造器来确保所有类实例在存储型属性都能获得初始值，他们分别是指定构造器和便利构造器
*/

//指定构造器和便利构造器
/*
  指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。
  每一个类都必须至少拥有一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器来满足这个条件。

  便利构造器是类中比较次要的，辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入的实例。
  你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清晰明了。
*/

//构造器链
/*
为了简化指定构造器和便利构造器之间的调用关系，Swift采用以下三条规则来限制构造器之间的代理调用
规则一：指定构造器必须调用其直接父类的指定构造器。
规则二：便利构造器必须调用同一个类定义的其他构造器。
规则三：便利构造器必须最终以调用一个指定构造器结束。
*/

//两段式构造过程
/*
Swift中类的构造过程包含两个阶段。第一个阶段，每个存储型属性通过引入他们的类的构造器来设置初始值。当每一个存储型属性值被确定后，第二个阶段开始，它给每个类一次机会在新实例准备使用之前进一步定制他们的存储型属性
两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完整的灵活性。两段式构造过程可以防止属性值在初始化之前被访问；也可以防止属性被另外一个构造器意外地赋予不同的值。
*/

//构造器的继承和重载
/*
跟objective-c中的子类不一样，Swift中的子类不会默认继承父类的构造器。Swift的这个机制可以防止一个父类的简单构造器被一个更专业的子类继承，并被错误的用来创建子类的实例。
假如你希望自定义的子类中能实现一个或多个跟父类相同的构造器--也许是为了完成一些定制的构造过程--你可以在你定制的子类中提供和重载与父类相同的构造器。
*/

//自动构造器的继承

//指定构造器和便利构造器的语法
   //类的指定构造器的写法和值类型简单构造器一样
//    init(parameters)
//    {
//        statement
//    }

//便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenient关键字，并使用空格将他们俩分开：
//    convenience init(parameters)
//    {
//        statement
//    }

class Food
{
    var name: String
    init(name: String)
    {
        self.name = name
    }
    
    convenience init()
    {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")

let mysteryMeat = Food()

class RecipeIngredient: Food
{
    var quantity: Int
    init(name: String,quantity: Int)
    {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String)
    {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppinListItem: RecipeIngredient
{
    var purchased = false
    var description: String
    {
        var output = "\(quantity) x \(name)  "
        output += purchased ? "√":"x"
        return output
    }
}

var breakfastList = [
    ShoppinListItem(),
    ShoppinListItem(name: "Bacon"),
    ShoppinListItem(name: "Eggs", quantity: 6)
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList
{
    println(item.description)
}

//通过闭包和函数来设置属性的默认值
/*
如果某个存储型属性的默认值需要特别的定制或准备，你就可以使用闭包或全局变量来为其属性提供定制的默认值。每当某个属性所属的新类型实例创建时，对应的闭包或函数会被调用，而他们的返回值会当做默认值赋值给这个属性的

这种类型的闭包或函数一般会创建一个跟属性类型相同的临时变量，然后修改他的值以满足预期的初始状态，最后将这个临时变量的值作为属性的默认值进行返回。
*/

struct Checkerboard
{
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10
        {
            for j in 1...10
            {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()  //闭包
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool
    {
        return boardColors[(row * 10) + column]
    }
}

let board = Checkerboard()
println(board.squareIsBlackAtRow(0, column: 1))
println(board.squareIsBlackAtRow(9, column: 9))










