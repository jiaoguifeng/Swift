//
//  main.swift
//  2.20
//
//  Created by jiaoguifeng on 1/20/15.
//  Copyright (c) 2015 jiaoguifeng. All rights reserved.
//

import Foundation

/* 扩展 */
/*
  扩展就是向一个已有的类，结构体，或者枚举类型添加新功能(functionlity)。这句话在没有权限获取原始代码的情况下扩展类型的能力(即逆向建模)。扩展和objective-c中的分类(catogories)类似。(不过与objectiv-c不同的是，Swift的扩展没有名字。)

Swift中的扩展可以：
1.添加计算型属性和计算静态属性
2.定义实例方法和类型方法
3.提供新的构造器
4.定义下标
5.定义和使用新的嵌套类型
6.使一个已有类型符合某个接口

注意：如果你定义了一个扩展向一个已有类型添加新功能，那么这个新功能对该类型的所有已有实例中都是可用的，即使他们是在你的这个扩展的前面定义的
*/

//扩展语法(Extension Syntax)
   //声明一个扩展使用关键字extension
        //extension SomeType
        //{
        //    //加到SomeType的新功能写到这里
        //}

/*
   一个扩展可以扩展一个已有类型，使其能够适配一个或多个协议(protocol).当这个情况发生时，接口的名字应该完全按照类和结构体的名字的方式进行书写
*/
//        extension SomeType: SomeProtocol,Anotherprotocol
//        {
//            //协议实现写在这里
//        }

//计算型属性
extension Double
{
    var km: Double
    {
        return self*1_000.0
    }
    
    var m: Double
    {
            return self
    }
    
    var cm: Double
    {
            return self/100.0
    }
    
    var mm: Double
    {
            return self/1000.0
    }
    
    var ft: Double
    {
            return self/3.28084
    }
}

let oneInch = 25.4.mm
println("One inch is \(oneInch) meters")

let threeFeet = 3.ft
println("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
println("A marathon is \(aMarathon) meters long")
/*
注意：扩展可以添加新的计算属性，但是不可以添加存储属性，也不可以向已有属性添加属性观测器(property observers)
*/


//构造器(initializers)
   //扩展可以向已有类添加新的构造器。这可以让你扩展其他类型，将您自己的定制类型作为构造器参数，或者提供该类型的原始实现中没有包含的额外初始化选项
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
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))


extension Rect
{
    init(center: Point, size: Size)
    {
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY),size: size)
     }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

//注意：如果你使用扩展提供了一个新的构造器，你依然有职责保证构造过程中能够让所有实例完全初始化

//方法(Method)
  //扩展可以向已有类型添加新的实例方法和类型方法
extension Int
{
    func repetitions(#task: () -> ())  //
    {
        for i in 0..<self
        {
            task()
        }
    }
}

//3.repetitions(
//    {
//        println("hello world")
//    }
//)

3.repetitions(task: {println("hello world")})
3.repetitions{println("Goodbye!!!")}  //trailing闭包

//修改实例方法(Mutating Instance Methods)
  //通过扩展添加的实例方法也可以修改实例方法。结构体和枚举类型中的修改self或其属性的方法必须将该实例方法标注成mutating，正如来自原始实现的修改方法一样。
extension Int
{
    mutating func square()  //修改self值 加mutating
    {
        self = self * self
    }
}

var someInt = 3
someInt.square()
println(someInt)

//下标(Subscripts)
  //扩展可以向一个已有类型添加下标。下面的例子向Swift内奸类型Int添加了一个整型下标。该下标[n]返回十进制数字从右到左的第n个数字

extension Int
{
    subscript(var digitIndex: Int) -> Int
    {
        var decimalBase = 1
        while digitIndex > 0
        {
            decimalBase *= 10
            --digitIndex
        }
        
        return (self / decimalBase) % 10
    }
}

println(746381295[0])

println(746381295[1])

println(746381295[2])

println(746381295[8])

println(746381295[10])  //0

//嵌套类型(Nested Types)
  //扩展可以向已有的类，结构体和枚举添加新的嵌套类型

extension Character
{
    enum Kind
    {
        case Vowel, Consonant, Other
    }
    
    var kind: Kind
    {
        switch String(self).lowercaseString
        {
            case "a", "e", "i", "o", "u":
                return .Vowel
            case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
                return .Consonant
            default:
                return .Other
        }
    }
    
}


