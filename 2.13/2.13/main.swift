//
//  main.swift
//  2.13
//
//  Created by jiaoguifeng on 12/23/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 继承 */
/* 
一个类可以继承(inherit)另一个类的方法(methods),属性(property)和其他属性。当一个类继承其他类时，继承类叫做子类(subclass)，被继承类叫超类(或父类，superclass)。在Swift中，继承是区分“类”和其他类型的一个基本特征

在Swift中，类可以调用和访问超类的方法，属性和附属脚本(subscript)，并且可以重写(override)这些方法，属性和附属脚本来优化和修改他们的行为。
Swift会检查你的重写定义在超类中是否有匹配的定义，一次确保你的重写行为是正确的。

可以为类中继承来的属性添加属性观察器(property observer)，这样一来，当属性值发生改变时，类就会被通知到。可以为任何属性添加属性观察器，无论它原来被定义为存储型属性(stored property)还是计算型属性(computed property)。
*/

//定义一个基类(base class)
   //不继承其他类的，称之为基类
   //Swift中的类并不是从一个通用的基类继承而来的，如果你不为你定义的类制定一个超类(基类)的话，这个类自动成为基类
class Vehicle
{
//    var numberOfWheels: Int
//    var maxPassagers: Int
//    func description() -> String
//    {
//        return "\(numberOfWheels) wheels; up to \(maxPassagers) passagers"
//    }
//    
//    init()
//    {
//        numberOfWheels = 0
//        maxPassagers = 1
//    }
    var currentSpeed = 0.0
    var description: String
    {
       return "traveling at \(currentSpeed)"
    }
    
    func makeNoise()
    {
        //do nothing
    }
}

//子类生成
  //子类生成(Subclassing)指的是在一个已有类的基础上创建一个新的类

class Bicycle: Vehicle
{
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
println("Bicycle: \(bicycle.description)")

class Tandem: Bicycle
{
    var currentNumberOfPassagers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassagers = 2
tandem.currentSpeed = 22.0
println("Tandem: \(tandem.description)")

//重写
/* 子类可以为继承来的实例方法(instance method)，类方法(class method)，实例属性(instance property)，或附属脚本(subscript)提供自己定制的实现，我们把这种行为叫重写(overriding)
 重写定义的前面加上override关键字
*/

//访问超类的方法，属性及附属脚本
   //在合适的地方，你可以通过使用super前缀来访问超类版本的方法，属性及附属脚本

//重写方法
class Train: Vehicle
{
    override func makeNoise()
    {
        println("Choo Choo")
    }
}

let train = Train()
println(train.makeNoise())

//重写属性的Getters和Setters
/*
你可以提供定制的getter(或setter)来重写任意继承来的属性，无论继承来的属性是存储型还是计算型的属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。你在重写一个属性的时候，必须将它的名字和类型都写出来，这样才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配的
你可以将一个继承来的只读属性重写为一个读写属性，只需要你在重写版本的属性里提供getter和setter方法即可，但是你不可以将一个继承来的读写属性重写为一个只读属性

注意：如果你在重写属性中提供了setter，那么你也一定要提供getter，如果你不想在重写版本中的getter里修改继承来的属性值，你可以直接返回super.someProperty来返回继承来的值。
*/

class Car: Vehicle
{
    var gear = 1
    override var description: String
    {
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
println("Car: \(car.description)")

//重写属性观察器
/*
你可以在属性重写中为一个继承来的属性添加属性观察器。这样一来，当继承来的属性值发生改变时，无论那个属性原来是如何实现的。
注意：你不可以为继承来的常量存储属型或继承来的只读计算型属性添加属性观察器，这样的属性是不可以被设置的，所以，为他们提供willSet或didSet实现是不恰当的。此外还要注意，你不可以同时提供重写的setter和重写的属性观察器。如果你相观察属性值的变化，并且你已经为那个属性提供了定制的setter，那么你在setter中就可以观察到任何值变化了
*/

class AutomaticCar: Car
{
    override var currentSpeed: Double
    {
        didSet{
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
println("AutomaticCar: \(automatic.description)")

//防止重写
/*
你可以通过吧方法，属性或附属脚本标记为final来防止他们被重写，只需要在声明关键字前加上final特性即可
如果你重写了final方法，属性或附属脚本，在编译时会报错。在扩展中，你添加到类里的方法，属性或附属脚本也可以在扩展的定义里标记final。
你可以通过关键字class前添加final特性(final class)来将整个类标记为final的，这样的类是不可以被继承的，否则会报错。
*/















