//
//  main.swift
//  2.4
//
//  Created by jiaoguifeng on 11/4/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 集合类型 */
/*
数组：按顺序存储相同类型的多重数据，objective-c中可以存储任意类型的实例并且不提供他们返回对象的任何本质信息
字典：无序存储相同类型数据值但是需要由独立的标示符引用和寻址(就是键值对)
*/

/* 数组 */
var shoppingList : [String] = ["Eggs","Milk"]  //最新官方文档已经修改，旧版：var shoppingList : String[] = ["Eggs","Milk"]
var shoppingList1 = ["Eggs","Milk"] //推断机制，推断出[String]
println(shoppingList)

println("The shopping list contains \(shoppingList.count) items")

if shoppingList.isEmpty
{
    println("The Shopping list is empty")
}
else
{
    println("The Shopping list is not empty")
}

//数组中增加元素，由两种方法
shoppingList.append("Flour")    //1
shoppingList += ["Baking Powder"] //2 最新官方文档已经修改，旧版：shoppingList += "Baking Powder"
shoppingList += ["Chocolate Spread","Cheese","Butter"]
println("The shopping list contains \(shoppingList.count) items")

//下标获取数组中的数据项
var firstItem = shoppingList[0] //注意：Swift中索引总是从0开始

//通过下标来改变某个索引值对应的数据值
shoppingList[0] = "Six eggs"
println(shoppingList)

//可以利用下标来一次修改一系列数据值
shoppingList[4...6] = ["Bananas","Apples"]
shoppingList[4..<6] = ["Bananas","Apples"]
println(shoppingList)

/*
注意：我们不能使用下标号在数组尾部添加新项。如果我们试着用这种方法对索引越界的数据进行检索或者设置新值的操作，会引发一个运行时错误。可以使用索引值和数组的count属性进行比较来在使用某个索引之前先验证是否有效。除了Count等于0时(说明数组为空数组)，最大索引值一直是count-1，因为数组都是零起索引
*/

shoppingList.insert("Mapple Syrup", atIndex: 0) //在第一个位置增加一个数据值，count加1
println(shoppingList)

let mappleSyrup = shoppingList.removeAtIndex(0)  //索引对应项的数据值
println(shoppingList)
println(mappleSyrup)

let apples = shoppingList.removeLast()
println(shoppingList)
println(apples)

//数组的遍历
for item in shoppingList
{
    println(item)
}

for (index,value) in enumerate(shoppingList)
{
    println("Item \(index + 1) : \(value)")
}

//创建并且构造一个数组
var someInts = [Int]() // 最新官方文档已经修改，旧版：var someInts = Int[]()
println(someInts)

someInts.append(3)
println(someInts)

someInts = [2,3,4,5,6,7,8,9,1,0]
println(someInts)

var threeDoubles = [Double](count: 3, repeatedValue: 0.0) // 最新官方文档已经修改，旧版：var threeDoubles = Double[](count: 3, repeatedValue: 0.0)
println(threeDoubles)

var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)
println(anotherThreeDoubles)

//使用加法操作法(+)来组合两种已存在的相同类型数组。新数组的数据类型会被从两个数组的数据类型中推断出来
var sixDoubles = threeDoubles + anotherThreeDoubles
println(sixDoubles)

/* 字典 */
//字典是一种存储相同类型多重数据的存储器。每个值(value)都关联独特的键(key),键作为字典中的这个数据值的标示符。
var airportss : Dictionary<String,String> = ["TYO":"Tokyo","DUB":"Dublin"] //最新官方文档已经修改，这个是旧版本，依然可以使用
var airports : [String : String] = ["TYO":"Tokyo","DUB":"Dublin"] //最新官方文档

//读取和修改字典
airports["LHR"] = "London"
println(airports)

airports["LHR"] = "London Heathrow"  //更新键值对应的value
println(airports)

if let oldValue = airports.updateValue("Dublin Internation", forKey: "DUB") //返回值是更新值之前的原值，方便检测更新是否成功
{
    println("The old value for DUB was \(oldValue)")
}
println(airports)

if let airportName = airports["DUBs"]
{
    println("The name of airport is \(airportName)")
}
else
{
    println("That airport is not in the airports dictionary")
}

//还可以使用下标语法来通过给某个键的对应值赋值为nil来从字典里移除一个键值对
airports["APL"] = "Apple Internation"
println(airports)

airports["APL"] = nil
println(airports)

if let removedValue = airports.removeValueForKey("DUB")
{
    println("The removed airport's name is \(removedValue)")
}
else
{
    println("the airport dictionary does not contain a value for DUB.")
}

//字典遍历
for (airportCode,airportName) in airports
{
    println("\(airportCode) : \(airportName)")
}

for airportCode in airports.keys
{
    println("Airport Code : \(airportCode)")
}

for airportName in airports.values
{
    println("Airport Name : \(airportName)")
}

//如果我们只是需要使用某个字典的键集合或者值集合来作为某个接受Array实例API的参数，可以直接使用keys或者values属性直接构造一个新数组

//let airportCodes = Array(airports.keys)
let airportCodes = [String](airports.keys) // 最新官方文档已经修改，旧版：let airportCodes = Array(airports.keys)，但是可以使用
println(airportCodes)
let airportName = [String](airports.values) // 最新官方文档已经修改，旧版：let airportCodes = Array(airports.values)，但是可以使用
println(airportName)

//创建一个空字典
var nameOfIntegers = [Int:String]() // 最新官方文档已经修改，旧版：var nameOfIntegers = Dictionary<Int,String>()
nameOfIntegers[16] = "sixteen"  //现在字典中包含一个键值对了

nameOfIntegers = [:]  //现在又成了一个Int，String类型的空字典了

//测试不可变字典是否可以修改，测试失败，不可以修改
//let testAirport : [String:String] = ["TYO":"Tokyo","DUB":"Dublin"]
//testAirport["TYO"] = "Hello"
//测试不可变数组是否可以修改，测试失败，不可以修改
//let testArray : [String] = ["Eggs","Milk"]
//testArray[0] = "Eggg"

