//
//  main.swift
//  2.15
//
//  Created by jiaoguifeng on 12/26/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 反初始化 */
/*
在一个类的实例被释放之前，反初始化函数会被立刻调用。用关键字deinit来标示反初始化函数，类似于初始化函数用init来标示，反初始化只适用于类类型。
Swift会自动释放不在需要的实例以释放资源。如自动引用计数那一章描述，Swift通过自动引用计数(ARC)处理实例的内存管理。通常当你的实例释放时不需要手动的去清理。但是，当使用自己的资源时，你可以需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前关闭该文件。

在类的定义中，每个类最多只能有一个反初始化函数。反初始化函数不带任何参数，在写法上不带括号。

    deinit
    {

    }
反初始化函数在实例释放发生前一步自动调用。不允许自动调用自己的反初始化函数。子类继承了父类的反初始化函数，并且在子类反初始化函数实现的最后，父类的反初始化函数被自动调用。即使子类没有提供自己的反初始哈函数，父类的反初始化函数也总是被调用
*/

struct Bank
{
    static var coinsInBank = 10_000
    static func vendCoins(var numberOfCoinsToVend: Int) -> Int
    {
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receiveCoins(coins: Int)
    {
        coinsInBank += coins
    }
}

class Player
{
    var coinsInPurse: Int
    init(coins: Int)
    {
        coinsInPurse = Bank.vendCoins(coins)
    }
    
    func winCoins(coins: Int)
    {
        coinsInPurse += Bank.vendCoins(coins)
    }
    
    deinit
    {
        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
println("A new player has joined the game with \(playerOne!.coinsInPurse) coins")

println("There are now \(Bank.coinsInBank) coins left in the bank")


playerOne!.winCoins(2000)
println("PlayerOne won 2000 coins and now has \(playerOne!.coinsInPurse) coins")

println("The bank new only has \(Bank.coinsInBank) coins left")

playerOne = nil
println("Playerone has left the game")

println("The bank now has \(Bank.coinsInBank) coins")














