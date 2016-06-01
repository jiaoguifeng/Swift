//
//  main.swift
//  2.17
//
//  Created by jiaoguifeng on 1/15/15.
//  Copyright (c) 2015 jiaoguifeng. All rights reserved.
//

import Foundation

/* 自判断链接 */
/*
自判断链接(Optional Chaining)是一种可以请求和调用属性、方法及子脚本的过程，它的自判断性体现于请求和调用的目标当前可能为空(nil).如果自判断的目标有值，那么调用就会成功；相反，如果选择的目标为空(nil),则这种调用将返回空(nil).

注意：Swift的自判断链和objective-c中的消息为空有些相似，但是Swift可以使用在任意类型中，并且失败与否可以被检测到。
*/

class Person1
{
    var residence: Residence1?
}

class Residence1
{
    var numberOfRooms = 1
}


let john = Person1()

//let roomCount = john.residence!.numberOfRooms  如果你想使用声明符！强制拆包(john.residence!)获得john.residence属性numberOfRooms属性值，将会印发运行时错误，因为这时没有可以供拆包的residence值

//当john.residence不为nil时，会运行通过，且会将roomCount设置成一个int类型的合理值。然而，如上所述，当residence为空时，会导致运行时错误（fatal error: unexpectedly found nil while unwrapping an Optional value）

if let roomCount = john.residence?.numberOfRooms  //自判断链接提供了一种另一个获得numberOfRoom的方法。利用自判断链接，使用问好来替代原来！的位置：
{
    println("John's residence has \(roomCount) room(s)")
}
else
{
    println("unable to retrive the number of rooms")
}

//因为这种尝试获得numberOfRooms的操作可能失败，自判断链接返回int？类型值，或者称作“自判断Int”。当residence是空的时候，选择Int将会为空，因此会出现无法访问numberOfRooms的情况。


//为自判断链接定义模板类
  //后面的代码定义了四个将在后面使用的模板类，其中包括多层自判断链接。这些类由上面的Person和Residence模型通过添加一个Room和一个Address类拓展的。

//Person类定义和之前相同

class Person
{
    var residence: Residence?
}

class Residence
{
    var rooms = [Room]()
    var numberOfRooms: Int
    {
       return rooms.count
    }
    
    subscript(i: Int) -> Room
    {
        return rooms[i]
    }
    
    func printNumberOfRooms()
    {
        println("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room
{
    let name: String
    init(name: String)
    {
        self.name = name
    }
}

class Address
{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String?
    {
        if buildingName != nil
        {
            return buildingName
        }
        else if buildingNumber != nil
        {
            return buildingNumber
        }
        else
        {
            return nil
        }
    }
}

//通过自判断链接调用属性

let johns = Person()
if let roomCount = johns.residence?.numberOfRooms
{
    println("John's residence has \(roomCount) room(s)")
}
else
{
    println("unable to retrive the number of rooms")
}

//通过自判断链接调用方法
/*
你可以使用自判断链接来调用自判断值的方法并检测方法调用是否成功。即使这个方法没有返回值，你依然可以使用自判断链接来达成这一目的。

func printNumberOfRooms()
{
   println("The number of rooms is \(numberOfRooms)")
}

这个方法没有返回值。但是，没有返回值类型的函数和方法有一个隐式的返回值类型void

如果你利用自判断链接调用此方法，这个方法的返回值类型将是void？，而不是void，因为当通过自判断链接调用此方式返回值总是自判断类型。
*/

if johns.residence?.printNumberOfRooms() != nil
{
    println("It was possible to print the number of rooms")
}
else
{
    println("It was not possible to print the number of rooms")
}

//使用自判断链接调用子脚本

if let firstRoomName = johns.residence?[0].name
{
   println("The first room name is \(firstRoomName).")
}
else
{
    println("unable to retrive the first room name.") //打印这个
}

let johnsHouse = Residence()

johnsHouse.rooms.append(Room(name: "Living room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))

johns.residence = johnsHouse

if let firstRoomName = johns.residence?[0].name
{
    println("The first room name is \(firstRoomName).")
}
else
{
    println("unable to retrive the first room name.") //打印这个
}

//连接多层链接
if let johnsStreet = johns.residence?.address?.street
{
    println("Johns's street name is \(johnsStreet)")
}
else
{
    println("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingNumber = "The Larches"
johnsAddress.street = "Laurel Street"
johns.residence!.address = johnsAddress

if let johnsStreet = johns.residence?.address?.street
{
    println("Johns's street name is \(johnsStreet)")
}
else
{
    println("Unable to retrieve the address.")
}

//链接自判断返回值的方法
if let buildingIdentifier = johns.residence?.address?.buildingIdentifier()
{
    println("John's building identifier is \(buildingIdentifier).")
}

if let upper = johns.residence?.address?.buildingIdentifier()?.uppercaseString
{
    println("John's uppercase building identifier is \(upper).")
}




