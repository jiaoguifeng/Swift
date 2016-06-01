//
//  main.swift
//  2.6
//
//  Created by jiaoguifeng on 11/7/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 函数 */
/*
函数是执行特定任务的代码自包含块。Swift的统一的功能语法足够灵活的，可以表达任何东西，无论是不带参数名称的简单的样式函数，还是带本地和外部参数的复杂的objective-c样式方法
Swift中的每一个函数都有一个类型，包括函数的参数类型和返回类型。
*/
func sayHello(personName:String) -> String
{
    let greeting = "Hello, " + personName + "!"
    return greeting
}
println(sayHello("jiaoguifeng"))

//函数可以有多个输入形参，把他们写到函数的括号内，并用逗号隔开。
func halfOpenRangeLength(start:Int,end:Int) -> Int
{
    return end - start
}
println(halfOpenRangeLength(1,10))

//不需要返回值的函数,
func sayGoodbye(personName:String)
{
    println("Goodbye, \(personName)")
}

sayGoodbye("SB")

//多返回值函数
func count(string : String) -> (vowels:Int,consonants:Int,others:Int)
{
    var vowels = 0,consonants = 0,others = 0
    for character in string
    {
        switch String(character).lowercaseString
        {
            case "a","e","i","o","u":
                ++vowels
            case "b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z":
                ++consonants
            default:
                ++others
        }
    }
    
    return (vowels,consonants,others)
}

let total = count("some arbitrary string!")
println("\(total.vowels) vowels and \(total.consonants) consonants")

//外部参数名
func join(string s1:String,toString s2:String,withJoiner joiner:String) -> String
{
    return s1+joiner+s2
}

println(join(string: "Hello", toString: "world", withJoiner: ", "))

//外部参数名称速记
func containsCharacter(#string : String, #characterToFind : Character) -> Bool //(#)作为名字的前缀，这就告诉Swift使用名字相同的本地和外部参数名称
{
    for character in string
    {
        if character == characterToFind
        {
            return true
        }
    }
    return false;
}

let containsAVee = containsCharacter(string: "aardvark", characterToFind: "v")
println(containsAVee)

//默认参数值
func joins(string s1:String,toString s2:String,withJoiner joiner:String = " ") -> String
{
    return s1+joiner+s2
}
println(joins(string: "hello", toString: "world"))

//可变形参
/*
一个可变形参可以接受零个或者多个指定类型的值。当函数调用时，你可以使用可变形参来指定--形参可以用来传递任意数量的输入值。可通过在形参的类型名后面插入三个点符号(...)来编写可变形参
*/

/*
传递至可变形参的值在函数主体内是以适当类型的数组存在的。例如，一个可变参数的名字为numbers和类型Double...在函数体内就可以名为numbers类型为[Double]的常量组
*/
func aritheticMean(numbers : Double...) -> Double
{
    var total : Double = 0
    for number in numbers
    {
        total += number
    }
    
    return total / Double(numbers.count)
}
println(aritheticMean(1,2,3,4,5))

//常量形参和变量形参
/*
函数的形参默认是常量。师徒在函数体内改变函数形参的值会引发一个编译时错误，意味着你不能改变形参的值。
但是有时候，函数有一个形参值的变量副本是非常有用的，您可以指定一个或者多个形参作为变量形参，从而避免在函数内部为自己定义一个新的变量。变量参数是变量而非常量，并给函数一个可修改的形参值副本
*/
func alignRight(var string :String ,count : Int ,pad :Character) -> String //string可以在函数体中修改
{
    let amountToPad = count - countElements(string)
    
    if amountToPad < 1
    {
        return string
    }
    
    let padString = String(pad)
    for _ in 1...amountToPad
    {
        string = padString + string
    }
    return string
}

let originalString = "hello"
let paddedString = alignRight(originalString, 10, "-")
println(paddedString)

//in-out形参
/*
变量形参只能在函数本身内改变，如果你想让函数改变形参值，并想要在函数调用结束后保持形参值的改变，那你就可以把形参定义为in-out形参
通过在形参定义的开始添加inout关键字来编写in-out形参。
你只能传递一个变量作为in-out形参对应的实参。你不能传递一个变量或者字面值作为实参，因为常量或者字面值不能被修改。
提示：in-out参数不能有默认值，可变参数(var定义)的参数也不能被标记为inout。如果您标记参数为inout，它不能同事被标记为var或者let
*/

func swapTwoInts(inout a : Int,inout b :Int)
{
    let temportaryA = a
    a = b
    b = temportaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
println("someInt is now \(someInt),and anotherInt is now \(anotherInt)")

//函数类型
   //每一个函数都有特定的函数类型，有函数的形参类型和返回值构成
func addTwoInts(a:Int,b:Int) -> Int
{
    return a+b
}
func mutiplyTwoInts(a:Int,b:Int) -> Int
{
    return a * b
}
func printHelloWorld()  //这个函数的类型是()->(),或者说“没有形参的函数，并返回void。”没有指明返回值的函数通常会返回void，在swift中相当与一个空元组，显示为()
{
    println("hello,world")
}

//使用函数类型
var mathFunction : (Int,Int) -> Int = mutiplyTwoInts
println("Result : \(mathFunction(2,3))")

let anotherMathFunction = addTwoInts //Swift自动推断函数的类型

//作为形参类型的函数类型
func printMathResult(mathFunction:(Int,Int) -> Int,a:Int,b:Int)
{
    println("Result:\(mathFunction(a,b))")
}

printMathResult(mutiplyTwoInts,3,5)

//作为返回类型的函数类型
/*
你可以将一个函数类型作为另一个函数的返回值类型。你可以在返回函数的返回箭头(->)后面立刻编写一个完整的函数类型来实现
*/
func stepForward(input:Int) -> Int
{
    return input + 1
}
func stepBackward(input:Int) -> Int
{
    return input - 1
}

func chooseStepFunction(backwards:Bool) -> (Int)->Int
{
    return backwards ? stepBackward:stepForward
}

var currentValue = 3
let moveNearToZero = chooseStepFunction(currentValue > 0)

println("Counting to zero:")
while currentValue != 0
{
    println("\(currentValue)")
    currentValue = moveNearToZero(currentValue)
}

println("zero!")

//嵌套函数
/*
迄今为止所有你在本章遇到的函数都是全局函数，在全局作用域下定义。其实你还可以在其他函数体中定义函数，被成为嵌套函数
嵌套函数对外界是隐藏的，但仍然可以通过包裹的函数调用和使用它。enclosing function也可以返回一个嵌套函数，以便在其他作用域中使用嵌套函数
*/
func chooseStepFunction1(backwards:Bool) -> (Int)->Int
{
    func stepForward1(input:Int)-> Int
    {
        return input + 1
    }
    
    func stepBackward1(input:Int)->Int
    {
        return input - 1
    }
    
    return backwards ? stepBackward1:stepForward1
}

var currentValue1 = -4
let moveNearToZero1 = chooseStepFunction1(currentValue1 > 0)

while currentValue1 != 0
{
    println("\(currentValue1)...")
    currentValue1 = moveNearToZero1(currentValue1)
}
println("zero!")




