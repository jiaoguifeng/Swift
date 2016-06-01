//
//  main.swift
//  2.7
//
//  Created by jiaoguifeng on 11/10/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 闭包 */
  //闭包是功能性自包含模块，可以在代码中被传递和使用。Swift中的闭包与C和objective-c中的block以及其他一些编程语言中的lambdas比较类似
  //闭包可以捕获和存储其所在上下文中任意常量和变量的引用。这就是所谓的闭包并包裹着这些常量和变量，俗称闭包。
/*
在 函数 章节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包采取如下三种形式之一：
1.全局函数是一个有名字但是不会捕获任何值的闭包
2.嵌套函数是一个有名字并且可以捕获其封闭函数区域内值的闭包
3.闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量和常量值的没有名字的闭包
*/

//sort函数 
   //Swift标准库提供了sort函数，会根据您提供的排序闭包将已知类型数组中的值进行排序。一旦排序完成，函数会返回一个与原数组大小相同的数组，该数组中包含已经正确排序的同类型元素。
let names = ["Chris","Alex","Ewa","Barry","Daniella"]
func backwards(s1 : String,s2 : String) -> Bool
{
    return s1 > s2
}

var reversed = sorted(names,backwards) //最新官方文档已修改，旧版：var reversed = sort(names,backwards)，编译错误，无法识别sort函数

reversed = sorted(names,{(s1:String,s2:String) -> Bool in return s1 > s2})

reversed = sorted(names,{s1,s2 in return s1 > s2})

//reversed = sorted(names,{s1,s2 in s1 > s2}) //编译有问题

//reversed = sorted(names,{$0 > $1}) //编译有问题

reversed = sorted(names, >)

//Trailing闭包
/*
如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用Trailing闭包来增加函数的可读性。
Trailing闭包是一个书写在函数括号之外(之后)的闭包表达式，函数支持将其作为最后一个参数调用。
*/

func someFunctionThatTakesAClosure(closure:() -> ())
{
    //函数体部分
}

someFunctionThatTakesAClosure({/*闭包主体部分*/})

let digitNames = [0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",5:"Five",6:"Six",7:"Seven",8:"Eight",9:"Nine"]
let numbers = [16,58,510]

let strings = numbers.map{
    (var number) -> String in
    var output = ""
    while number > 0
    {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    
    println(output)
    return output
}

//捕获(Capture)
/*
闭包可以在其定义的上下文中捕获常量和变量。即使定义这些常量呵呵变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
Swift最简单的闭包形式是嵌套函数，也就是定义在其他函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
*/
/*
下例为一个叫做makeIncrementor的函数，其包含了一个叫做incrementor嵌套函数。嵌套函数incrementor从上下文捕获两个值，runingTotal和amount。之后makeIncrementor将incrementor作为闭包返回。每次调用incrementor时，都会以amount作为增量增加runningTotal的值
*/
func makeIncrementor(forIncrement amount:Int) -> ()-> Int
{
    var runningTotal = 0
    
    func incrementor() -> Int
    {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)
var total = incrementByTen()
println(total)

total = incrementByTen()
println(total)

total = incrementByTen()
println(total)

//如果您创建了另一个incrementor，其会有一个属于自己的独立的runningTotal变量的引用。下面这个例子中，incrementBySeven捕获了一个新的runningTotal变量，该变量和incrementByTen中捕获的变量没有任何联系：
let incrementorBySeven = makeIncrementor(forIncrement: 7)
var sevenTotal = incrementorBySeven()
total = incrementByTen()
println(sevenTotal)
println(total)

//闭包是引用类型
//上面的例子，incrementByTen和incrementorBySeven是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量值，这是因为函数和闭包都是引用类型。无论您将函数/闭包赋值给一个常量还是变量，您实际上都是将常量/变量的值设置为对应函数/闭包的引用，上面的例子，incrementorBySeven指向闭包的引用是一个常量，而非闭包内容本身。
//这也意味着如果您将闭包赋值给了连个不同的常量/变量，两个值都会指向同一个闭包：
let alsoIncrementByTen = incrementByTen
var x = alsoIncrementByTen()
println(x)







