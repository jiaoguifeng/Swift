//
//  main.swift
//  2.11
//
//  Created by jiaoguifeng on 12/5/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 方法 */
/*
方法是和某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务和功能。
类、结构体、枚举也可以定义类型方法，类型方法与类型本身相关联。类型方法与objective-c中的类方法(class methods)相似。

结构体和枚举能够定义方法是Swift与Objective-c的主要区别之一。
*/

//实例方法(Instance Methods)
class Counter
{
    var count = 0
    func increment()
    {
        count++
    }
    
    func incrementBy(amount: Int)
    {
        count += amount
    }
    
    //after added
    func incrementBy(amount: Int ,numberOfTimes: Int)
    {
        count += amount * numberOfTimes
    }
    
    func reset()
    {
        count = 0
    }
}

let counter = Counter()
counter.increment()
println(counter.count)

counter.incrementBy(5)
println(counter.count)

counter.incrementBy(5, numberOfTimes: 3)
println(counter.count)

counter.reset()
println(counter.count)

//方法的局部参数名称和外部参数名称(Local and External Parameter Names for Methods)
//如上

//self属性(The self Property)
/*
类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身
*/
struct Point
{
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool
    {
        return self.x > x    //如果不使用self前缀，Swift就认为两次使用的x都指的是名称为x的函数参数
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0)
{
    println("This point is to the right of the line where x == 1.0")
}

//在实例方法中修改值类型(Modifying Value Types from Within Instance Methods)

/*
结构体和枚举是值类型。一般情况下，值类型的属性不能在它的实例方法中修改。

但是，如果你确实要在某个具体的方法中修改结构体或者枚举的属性，你可以选择变异(mutating)这个方法，然后方法就可以从内部改变它的属性；并且它做的任何改变在方法结束时还会保留在原始结构中。方法还可以给它隐含的self属性赋值一个全新的实例，这个新实例在方法结束后将替换原来的实例。
*/

struct OtherPoint
{
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double)  //针对结构体和枚举
    {
//        x += deltaX
//        y += deltaY
        //第一种方法
        
        self = OtherPoint(x: x + deltaX, y: y + deltaY)
        //第二种方法
    }
}
var somesPoint = OtherPoint(x: 1.0, y: 1.0)  //let类型不能修改
somesPoint.moveByX(2.0, y: 3.0)
println("The point is now at (\(somesPoint.x), \(somesPoint.y))")

enum TriStateSwitch
{
    case Off, Low, High
    mutating func next()
    {
        switch self
        {
            case Off:
                self = Low
            case Low:
                self = High
            case High:
                self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low

ovenLight.next()
if ovenLight == TriStateSwitch.High
{
    println(ovenLight)
}

ovenLight.next()
if ovenLight == TriStateSwitch.Off
{
    println(ovenLight)
}

//类型方法
struct LevelTracker
{
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int)  //类型方法
    {
        if level > highestUnlockedLevel
        {
            highestUnlockedLevel = level
        }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool  //类型方法
    {
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool  //实例方法中修改值类型
    {
        if LevelTracker.levelIsUnlocked(level)
        {
            currentLevel = level
            return true
        }
        else
        {
            return false
        }
    }
}

class Player
{
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int)
    {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    
    init(name: String)
    {
        playerName = name
    }
}

var player = Player(name: "jiao")
player.completedLevel(1)

println("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")


player = Player(name: "gui")
if player.tracker.advanceToLevel(6)
{
    println("player is now on level 6")
}
else
{
    println("level 6 has not yet been unlocked")
}


