//
//  main.swift
//  2.19
//
//  Created by jiaoguifeng on 1/20/15.
//  Copyright (c) 2015 jiaoguifeng. All rights reserved.
//

import Foundation

/* 类型嵌套 */

/*
枚举类型常被用于实现特定类或结构体的功能。同样的，也能够在有多种变量类型的环境中方便的定义通用类或结构体。为了实现这个功能，Swift允许你定义类型嵌套，可以在枚举类型、类和结构体中定义支持嵌套的类型。

要在一个类型中嵌套另一个类型，将需要嵌套的类型的定义写在被嵌套类型的区域{}内，而且可以根据需要定义多级嵌套
*/

//类型嵌套实例
struct BlackjackCard
{
    enum Suit: Character
    {
        case Spades = "H", Hearts = "S", Diamonds = "F", Clubs = "M"
    }
    
    enum Rank: Int
    {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Night, Ten
        case Jack, Queen, King, Ace
        
        struct Values
        {
            let first: Int, second: Int?
        }
        
        var values: Values
        {
            switch self
            {
                case .Ace:
                    return Values(first: 1, second: 11)
                case .Jack, .Queen, .King:
                    return Values(first: 10, second: nil)
                default:
                    return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank, suit: Suit
    var description: String
        {
            var output = "suit is \(suit.rawValue),"
            output += "value is \(rank.values.first)"
            if let second = rank.values.second
            {
                output += " or \(second)"
            }
            
            return output
        }
}


let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
println("theAceOfSpades: \(theAceOfSpades.description)")

//类型嵌套的引用
/*
在外部对嵌套类型的引用，是以被嵌套类型的名字为前缀，加上所要引用的属性名：
*/
let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue




















