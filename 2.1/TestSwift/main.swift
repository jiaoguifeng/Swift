//
//  main.swift
//  TestSwift
//
//  Created by jiaoguifeng on 11/3/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

var x = 0.0,y = 0.0,z = 0.0

var welcomeMessage:String
welcomeMessage = "hello"

//你可以用任何你喜欢的字符作为常量和变量名，包括Unicode字符
//let ??????? = "dogcow"   //可是这是啥意思呢，bugs...


var friendlyWelcome = "Hello"
friendlyWelcome = "Bonjour!"

println(friendlyWelcome)


//输出当前常量或者变量的值，放入圆括号中，并在圆括号前使用反斜杠将其转义
println("The current value of friendlyWelcome is \(friendlyWelcome)")


//关于分号的使用，不强制每句语句的结尾处使用分号(;)，当然也可以按照自己的习惯添加分号。但是有一种情况下必须要用分号，即在同一行写多条独立语句
let cat = "????";println(cat)

/* 别名 */
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min
println(maxAmplitudeFound)


/* 元组 */
  //元组，可以任意顺序的类型组合成一个元组，这个元组可以包含所有类型，例如(int,int,int),(String,Bool) 或者还有其他
let http404Error = (404,"Not Found")
  //你可以将一个元组的内容分解成单独的常量和变量，然后可以正常使用他们
let (statusCode,statusMessage) = http404Error
println("the status code is \(statusCode)")
println("the status message is \(statusMessage)")

  //如果你只需要一部分元组值，分解的时候可以吧忽略的部分用下划线(_)标记
let (justTheStatusCode,_) = http404Error
println("the status code is \(statusCode)")

 //还可以通过下标来访问元组中的单个元素
println("the status code is \(http404Error.0)")
println("the status message is \(http404Error.1)")

 //在定义元组的时候给单个元素命名
let http200Status = (statusCode:200,description:"OK")
println("the status code is \(http200Status.statusCode)")
println("the status message is \(http200Status.description)")

/* 可选 optionals */
    //有值，等于x  或者 没有值
    //暗示任意类型的值缺失
let possibleNumber = "123"
let convertedNumber = possibleNumber.toInt() //convertNumber被推测成Int？或者类型“optional Int”
println(convertedNumber)

/* if语句以及强制解析 */
if convertedNumber != nil  //貌似文档存在bug :  if convertedNumber
{
    println("\(possibleNumber) has an integer value of \(convertedNumber!)")
    //使用！来获取一个不存在的可选值会导致运行时错误。使用！来强制解析之前，一定要确保可选包含一个非nil的值
}
else
{
    println("\(possibleNumber) could not be converted to an integer")
}

/* 可选绑定 使用可选 */
   //使用可选绑定(optional binding)来判断可选是否包含值，如果包含就把值赋给一个临时常量或者变量，可选绑定可以在if和while语句中来对可选的值进行判断并把值赋给一个常量或者变量

if let actualNumber  = possibleNumber.toInt()  //对这里表示疑问 上面的if语句为啥要convertedNumber != nil才可以编译通过
{
    println("\(possibleNumber) has an integer value of \(actualNumber)")
}
else
{
    println("\(possibleNumber) could not be converted to an integer")
}

var serverResponseCode :Int? = 404
serverResponseCode = nil
  //注意：nil不能用于非可选的常量或者变量。如果代码中有常量或者变量需要处理值缺失的情况，把他们声明成对应的可选类型
  //如果你声明了一个可选常量或者变量但是没有赋值，他们会自动被设置为nil
var surveyAnswer :String? // surveyAnswer被自动设置为nil

  //注意：Swift的nil和ojbective-c中的nil不一样。在ojbective-c中，nil是指向不存在对象的指针。在Swift中，nil不是指针--他是一个确定的值，用来表示缺失。任何类型的可选都可以被设置成nil，不只是对象类型

/* 断言 */
let age = 2
assert(age >= 0, "A person's age connot be less than zero") //非常有用的调试工具
  //注意：断言可能导致你的应用程序终止，所以你应当仔细设计你的代码来让非法条件不会出现。然而，在你的应用发布之前，有时候非法条件可能出现，这时使用断言可以快速发现问题



