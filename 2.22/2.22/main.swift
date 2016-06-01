//
//  main.swift
//  2.22
//
//  Created by jiaoguifeng on 1/28/15.
//  Copyright (c) 2015 jiaoguifeng. All rights reserved.
//

import Foundation

/* 泛型 */
/*
泛型代码可以让你写出根据自我需求定义、适用于任何类型的，灵活且可重用的函数和类型。它可以让你避免重复的代码，用一种清晰和抽象的方式来表达代码的意图。

泛型是Swift强大特征中的一个，许多Swift标准库是通过泛型代码构建出来的。事实上，泛型的使用贯穿了整个语言手册，只是你没有发现而已。
*/

//泛型所解决的问题
  //非泛型函数
func swapTwoInts(inout a: Int, inout b: Int)
{
    let tmp = a
    a = b
    b = tmp
}

var someInt = 4
var anotherInt = 107

swapTwoInts(&someInt, &anotherInt)

println("someInt is now \(someInt),and anotherInt is now \(anotherInt)")

//泛型函数
func swapTwoValues<T>(inout a: T,inout b: T)
{
    let tmp = a
    a = b
    b = tmp
}

swapTwoValues(&someInt, &anotherInt)

println("someInt is now \(someInt),and anotherInt is now \(anotherInt)")

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
println("someString is now \(someString),and anotherString is now \(anotherString)")

//参数类型
/*
在上面的swapTwoValues例子中，占位类型T是一种类型参数的示例。类型参数指定并命名为一个占位类型，并紧随在函数名后面，使用一对尖括号括起来。
*/

//命名类型参数
  //在简单的情况下，泛型函数或泛型类型需要指定一个占位类型，如T，不过你可以使用任何有效的标示符来作为类型参数名。


//泛型类型


//类型约束


//关联类型






