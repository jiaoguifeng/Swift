//
//  main.swift
//  2.21
//
//  Created by jiaoguifeng on 1/21/15.
//  Copyright (c) 2015 jiaoguifeng. All rights reserved.
//

import Foundation

/* 协议 */

/*
 Protocol(协议)用于统一方法和属性的名称，而不实现任何功能。协议能够被类，枚举，结构体实现，满足协议要求的类，枚举，结构体被称为协议的遵循者。
 遵循者需要提供协议指定的成员，如属性，方法，操作符，下标等。
*/

//协议的语法

//属性要求
/*
  协议能够要求其遵循者必须包含有一些特定名称和类型的实例属性(instance property)或类属性(type property),也能够要求属性的(设置权限)settable和(访问权限)gettable,但它不要求属性是存储型属性(stored property)还是计算型属性(calulate property)。
*/

protocol FullyNamed
{
    var fullName: String {get}
}

struct Person: FullyNamed
{
    var fullName: String  //遵循协议
}

let john = Person(fullName: "John Appleseed")

class Startship: FullyNamed
{
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil)
    {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String
    {
        return (prefix != nil ? prefix! + " ": "") + name
    }
}

var ncc1701 = Startship(name: "Enterprese", prefix: "USS")

//方法要求
/*
  协议能够要求其遵循者必备某些特定的实例方法和类方法。协议方法的声明和普通方法声明相似，但他不需要方法内容。

注意：协议方法支持变长参数(variadic parameter),不支持默认参数(default parameter)。
前置class关键字表示协议中的成员为类成员；当协议用于被枚举或结构体遵循时，则使用static关键字：

*/

protocol SomeProtocol
{
    class func someTypeMethod()
}

protocol RandomNumberGenerator
{
    func random() -> Double
}

class LinearConfigruentialGenerator: RandomNumberGenerator
{
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double
    {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}

let generator = LinearConfigruentialGenerator()
println("Here's a random number:\(generator.random())")

println("And another one:\(generator.random())")

//突变方法要求
/*
能在方法或函数内部改变实例类型的方法称为突变方法。在值类型(特指结构体和枚举)中的函数前缀加上mutating关键字来表示该函数允许改变该实例和其属性的类型。

类中的成员为引用类型，可以方便的修改实例及其属性的值而无需改变类型；而结构体和枚举均为值类型(Value Type),修改变量的值就相当于修改变量的类型，而Swift默认不允许修改类型，因此需要前置nutating关键字来表示该函数能够修改类型

注意：用class实现协议中的mutating方法时，不用写mutating关键字；用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。
*/

protocol Togglable
{
    mutating func toggle()
}

enum OnOffSwitch: Togglable
{
    case Off,On
    mutating func toggle()
    {
        switch self
        {
           case Off:
              self = On
           case On:
              self = Off
        }
    }
}

var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()

//协议类型
/*
协议本身并不实现任何功能，但你可以将它当做类型来使用。
使用场景：
1.作为函数，方法或者构造器中的参数类型，返回值类型
2.作为常量，变量，属性的类型
3.作为数组，字典或者其他容器中的元素类型

注意：协议类型应与其他类型(Int,Double,String)的写法相同，使用驼峰式
*/
class Dice
{
    let sides: Int
    let generator: RandomNumberGenerator  //可以被赋值为任意遵循该协议的类型
    init(sides: Int, generator: RandomNumberGenerator)
    {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int
    {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearConfigruentialGenerator())
for _ in 1...5
{
    println("Random dice roll is \(d6.roll())")
}

//委托(代理)模式
/*
委托是一种设计模式，它允许类或结构体将一些需要他们负责的功能交由(委托)给其他的类型
委托的模式很简单，定义协议来封装那些需要被委托的函数和方法，使其遵循者拥有这些被委托的函数和方法。
委托模式可以用来响应特定的动作或接受外部数据源提供的数据，而无需要知道外部数据源的类型
*/

protocol DiceGame
{
    var dice: Dice {get}
    func play()
}

protocol DiceGameDelegate
{
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAndladders: DiceGame
{
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearConfigruentialGenerator())
    
    var square = 0
    var board: [Int]
    init()
    {
        board = [Int](count:finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    func play()
    {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare
        {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            
            switch square + diceRoll
            {
                case finalSquare:
                    break gameLoop
                case let newSquare where newSquare > finalSquare:
                    continue gameLoop
                default:
                    square += diceRoll
                    square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate
{
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame)
    {
        numberOfTurns = 0
        if game is SnakesAndladders
        {
            println("Started a new game of Snakes and Ladders")
        }
        
        println("The game is using a \(game.dice.sides)")
    }
    
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    {
        ++numberOfTurns
        println("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(game: DiceGame)
    {
        println("The game lasted for \(numberOfTurns) turns")
    }
}


let tracker = DiceGameTracker()
let game = SnakesAndladders()
game.delegate = tracker
game.play()

//在扩展中添加协议成员
protocol TextRepresentable
{
    func asText() -> String
}

extension Dice: TextRepresentable
{
    func asText() -> String
    {
        return "A \(sides) -sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearConfigruentialGenerator())
println(d12.asText())

extension SnakesAndladders: TextRepresentable
{
    func asText() -> String
    {
        return "A game of Snake and Ladders with \(finalSquare) squares"
    }
}

println(game.asText())

//通过延展补充协议声明
/*
当一个类型已经实现了协议中的所有要求，却没有声明时，可以通过扩展来补充协议声明
*/

struct Hamster
{
    var name: String
    func asText() -> String
    {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
println(somethingTextRepresentable.asText())
println(simonTheHamster.asText())

//注意：即使满足了协议的所有要求，类型也不会自动转变，因此你必须为他做出明显的协议声明

//集合中的协议类型
  //协议类型可以被集合使用，表示结合中的元素均为协议类型
let things: [TextRepresentable] = [game,d12,simonTheHamster]

for thing in things
{
    println(thing.asText())
}

//thing被当做TextRepresentable类型而不是Dice，DiceGame，Hamster等类型。因此能且仅能调用asText方法

//协议的继承
  //协议能够继承一个到多个其他协议。语法与类的继承相似，多个协议间用逗号(,)分隔

//协议合成
  //一个协议可由多个协议采用protocol<SomeProtocol,Anotherprotocol>这样的格式进行组合，称为协议合成(protocol composition)。
protocol Named
{
    var name: String {get}
}

protocol Aged
{
    var age: Int {get}
}

struct Persons: Named,Aged
{
    var name: String
    var age: Int

}

func wishHappyBirthday(celebrator: protocol<Named,Aged>)
{
    println("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}

let birthdayperson = Persons(name: "Molcolm", age: 21)
wishHappyBirthday(birthdayperson)

//注意:协议合成并不会生成一个新协议类型，而是将多个协议合成为一个临时的协议，超出范围后立即失效。

//验证协议的一致性
/*
使用is验证协议的一致性，使用as将协议类型转换(downcast)为的其他协议类型。检验与转换的语法和之前的相同。
1.is操作符用来检查实例是否遵循了某个协议。
2.as？返回一个可选值，当实例遵循协议时，返回该协议类型；否则返回nil
3.as用于强制向下转类型
*/

@objc protocol HasArea
{
    var area: Double {get}
}
//注意：@objc用来表示协议是可选的，也可以用来表示暴漏给objective-c的代码，此外，@objc型协议只对类有效，因此只能在类中检查协议的一致性。


class Circle: HasArea
{
    let pi = 3.1415927
    var radius: Double
    var area: Double
    {
        return pi * radius * radius
    }
    
    init(radius: Double)
    {
        self.radius = radius
    }
}

class Country: HasArea
{
    var area: Double
    init(area: Double)
    {
        self.area = area
    }
}

class Animal
{
    var legs: Int
    init(legs: Int)
    {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 234_610),
    Animal(legs: 4)
]

for object in objects
{
    if let objectWithArea = object as? HasArea
    {
        println("Area is \(objectWithArea.area)")
    }
    else
    {
        println("Something that doesn't have an area")
    }
}

//objects数组中的类型并不会因为向下转型而改变，当他们被赋值给objectWithArea时只被视为HasArea类型，因此只有area属性能够被访问。

//可选协议要求
  //可选协议含有可选成员，其遵循者可以选择是否实现这些成员。在协议中使用optioal关键字作为前缀来定义可选成员。
  //注意：可选协议只能在含有@objc前缀的协议中生效。且@objc的协议只能被类遵循

@objc protocol CounterDataSource  //@objc只用于类
{
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int {get}
}

//CounterDataSource含有incrementForCount的可选方法和fixedIncrement的可选属性
//注意：CounterDataSource的属性和方法都是可选的，因此可以在类中声明但不实现这些成员，尽管技术上允许这样做，不过最好不要这样做。

@objc class Counter
{
    var count = 0
    var dataSource: CounterDataSource?
    func increment()
    {
        if let amount = dataSource?.incrementForCount?(count)  //即使dataSource存在，但也不能保证其是否实现了incrementForCount方法，因此incrementForCount方法后面要加(?)标记
        {
            count += amount
        }
        else if let amount = dataSource?.fixedIncrement?
        {
            count += amount
        }
    }
}

class ThreeSource: CounterDataSource  //实现了协议
{
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4
{
    counter.increment()
    println(counter.count)
}

class TowardsZeroSource: CounterDataSource
{
    func incrementForCount(count: Int) -> Int
    {
        if count == 0
        {
            return 0
        }
        else if count < 0
        {
            return 1
        }
        else
        {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5
{
    counter.increment()
    println(counter.count)
}


