//
//  main.swift
//  2.8
//
//  Created by jiaoguifeng on 11/14/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 枚举 */
/*
枚举定义了一个通用类型的一组相关的值，使你可以在你的代码中以一个安全的方式来使用这些值。如果你熟悉C语言，你就会知道，在C语言中枚举指定相关名称为一组整数值。Swift中的枚举更加灵活，不必给每一个枚举成员(enumeration member)提供一个值。如果一个值(被认为是原始值)被提供给每一个枚举成员，则该值可以是一个字符串，一个字符，或者一个整数值或浮点值
此外，枚举成员可以指定任意类型的关联值存储到枚举成员值中，就像其他语言中的联合体(union)和变体(variants)。你可以定义一组通用的相关成员作为枚举的一部分，每一组都有不同的一组与它相关的适当类型的数值。
*/

enum CompassPoint
{
    case North
    case South
    case East
    case West
}

var directionToHead = CompassPoint.West //推断为CompassPoint类型
directionToHead = .East //一旦被声明为CompassPoint类型，你可以使用更短的点(.)语法将其设置为另一个CompassPoint的值

//匹配枚举值和Switch语句
directionToHead = .South
switch directionToHead
{
case .North:
    println("Lots of planets have a north")
case .South:
    println("Watch out for penguins")
case .East:
    println("Where the sun rises")
case .West:
    println("Where the skies are blue")
}

//关联值
enum Barcode
{
    case UPCA(Int,Int,Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909_51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")

/*
原始的Barcode。UPCA和其整数值被新的Barcode.QRCode和其字符串值所代替。条形码的常量和变量可以存储.UPCA或者.QRCode(连同它的关联值)，但是在任何指定时间只能存储其中之一。
*/

switch productBarcode
{
case .UPCA(let numberSystem,let identifier,let check):
    println("UPCA with value of \(numberSystem),\(identifier),\(check)")
case .QRCode(let productCode):
    println("QR Code with value of \(productCode)")
}

enum Planet : Int
{
    case Mercury = 1,Venus,Earth,Mars,Jupiter,Saturn,Uranus,Neptune
}

let earthOrder = Planet.Earth.rawValue
println(earthOrder)

let somePlanet = Planet(rawValue: 3)
println(somePlanet)



