//
//  main.swift
//  2.5
//
//  Created by jiaoguifeng on 11/6/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 控制流 */
/*
for循环，while循环，break，continue for-in循环
*/

//for循环
let base = 3
let power = 10
var answer = 1
for _ in 1...power
{
    answer *= base
}
println(answer)

for var index = 0;index < 3;++index
{
    println("index is \(index)")
}


//while循环

//do-while循环
   //while循环的另外一种形式，它和while的区别是在循环条件之前，先执行一次循环的代码块，然后重复循环直到条件为false

//if语句
var temperatureInFabrenheit = 30
if temperatureInFabrenheit <= 32
{
    println("It's very cold.Consider wearing a scarf.")
}

//Switch语句
let someCharacter:Character = "e"
switch someCharacter
{
    case "a","e","i","o","u":
        println("\(someCharacter) is a vowel")
    case "b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z":
        println("\(someCharacter) is a consonant")
    default:
    println("\(someCharacter) is not a vowel or a consonant")
}
/*
与C语言和objective-c中的switch语句不同，在Swift中，当匹配的case块中的代码执行完毕后，程序会终止switch语句，而不会继续执行下一个case块。这也就是说，不需要在case块中显式的使用break语句。这使得switch语句更加安全，更易用，也避免了因忘记写break语句而产生错误
*/


//元组
let somePoint = (1,1)
switch somePoint
{
    case (0,0):
       println("(0,0) is at the origin")
    case (_,0):
       println("(\(somePoint.0),0) is on the x-axis")
    case (0,_):
       println("(0,\(somePoint.1)) is on the y-axis")
    case (-2...2,-2...2): //表示范围
       println("(\(somePoint.0),\(somePoint.1)) is inside the box")
    default:
       println("(\(somePoint.0),\(somePoint.1)) is outside of the box")
}

//值绑定(Value Bindings)
let anotherPoint = (2,0)
switch anotherPoint
{
    case (let x,0):
       println("on the x-axis with an x value of \(x)")
    case (0,let y):
       println("on the y-axis with an y value of \(y)")
    case let(x,y):
       println("somewhere else at (\(x),\(y))")
}
/*
注意：这个switch语句不包含默认块。这是因为最后一个case--case let(x,y)声明了一个可以匹配余下所有值的元组。这使得switch语句已经完备了，因此不需要书写默认块
*/

//Case块的模式可以使用where语句来判断额外的条件
let yetAnotherPoint = (1,-1)
switch yetAnotherPoint
{
    case let(x,y) where x == y:
        println("(\(x),\(y)) is on the line x == y")
    case let(x,y) where x == -y:
        println("(\(x),\(y)) is on the line x == -y")
    case let(x,y):
        println("(\(x),\(y)) is just some arbitrary point")

}

//控制转移语句 continue，break，fallthrough，return
  //continue告诉一个循环体立刻停止本次循环迭代，重新开始下次循环迭代
  //break语句会立刻结束真个控制流的执行
  //fallthrough 执行下个case语句的内容

//标签条件(Labeled Statements)









