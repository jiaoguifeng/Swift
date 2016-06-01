//
//  main.swift
//  2.23
//
//  Created by jiaoguifeng on 1/29/15.
//  Copyright (c) 2015 jiaoguifeng. All rights reserved.
//

import Foundation

/* 高级运算符 */
/*
Swift的数值计算默认是不可溢出的。溢出行为会被捕获并报告为错误。你可以使用Swift为你准备的另一套默认允许溢出的数值运算符，如可溢出&+。所有允许溢出的运算符都是以&开始的。

可定制的运算符并不局限与那些预设的运算符，自定义有个性的中置，前置，后置及赋值运算符，当然也有优先级和结合性。
*/


//位运算符
  //按位取反运算符~ --对一个操作数的每一位按位取反

let initialBits: UInt8 = 15//0b00001111
let invertedBits = ~initialBits
println(invertedBits)

//按位与运算符 &
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits  //0b00111100

//按位或运算符 |
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedBits = someBits | moreBits  //0b11111110

//按位异或运算符
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits  //0b00010001

//按位左移、右移运算符 << / >>
  //无符整型的移位操作


//有符号整型的因为操作
/*
由于使用二进制补码表示，我们可以和正数一样对负数进行按位左移右移的，同样的，也是左移1位时乘以2，右移1时除以2
对有符号整数按位右移时，使用符号位(正数为0，负数为1)填充空白位。
1111111 --> 11111111
0111111 --> 00111111
*/
var a: Int8 = -32
a = (a << 1)
a = (a << 1)
println(a)

//溢出运算符
var potentialOverflow = Int16.max
// potentialOverflow += 1  报错，溢出了

var willOverflow = UInt8.max
println(willOverflow)
willOverflow = willOverflow &+ 1
println(willOverflow)

var willUnderflow = UInt8.min
println(willUnderflow)
willUnderflow = willUnderflow &- 1
println(willUnderflow)

//溢出运算符  &+ &- &* &/ &%

//优先级和结合性

//运算符函数
struct Vector2D
{
    var x = 0.0, y = 0.0
}

func + (left: Vector2D, right: Vector2D) -> Vector2D
{
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector

println("x: \(combinedVector.x), y: \(combinedVector.y)")


//组合赋值运算符
func += (inout left: Vector2D, right: Vector2D)
{
    left = left + right
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd

println("x: \(original.x), y: \(original.y)")

//前置和后置运算符
prefix func ++ (inout vector: Vector2D) -> Vector2D
{
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}

var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement
println("x: \(afterIncrement.x), y: \(afterIncrement.y)")


//比较运算符
func == (left: Vector2D, right: Vector2D) -> Bool
{
    return (left.x == right.x) && (left.y == right.y)
}

func != (left: Vector2D, right: Vector2D) -> Bool
{
    return !(left == right)
}

//自定义运算符








