//
//  main.swift
//  2.18
//
//  Created by jiaoguifeng on 1/19/15.
//  Copyright (c) 2015 jiaoguifeng. All rights reserved.
//

import Foundation

/* 类型转换 */
/* 
 类型转换是一种检查类实例的方式，并且/或者也是让实例作为它的父类或者子类的一种方式。
 类型转换在Swift中使用is和as操作符实现。这两个操作符提供了一个简单达意的方式去检查值的类型或者转换它的类型。
*/

//定义一个类层次作为例子
class MediaItem  //父类
{
    var name: String
    init(name: String)
    {
        self.name = name
    }
}

class Movie: MediaItem
{
    var director: String
    init(name: String,director: String)
    {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem
{
    var artist: String
    init(name: String, artist: String)
    {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
Movie(name: "Casablanca", director: "Michael Curtiz"),
Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
Movie(name: "Citizen Kane", director: "Orson Welles"),
Song(name: "The One And Only", artist: "Chesney Hawkes"),
Song(name: "Never Gonna Give You Up", artist: "Rick Astley"),
]

//检查类型
var movieCount = 0
var songCount = 0

for item in library
{
    if item is Movie
    {
        ++movieCount
    }
    else if item is Song
    {
        ++songCount
    }
}

println("Media library contains \(movieCount) movies and \(songCount) songs")

//向下转型
/*
某类型的一个常量或者变量可能在幕后实际上属于一个子类。你可以相信，上面就是这种情况。你可以尝试向下转到它的子类型，用类型转换操作符(as)

因为向下转型可能会失败，类型转换操作符带来两种不同形式。可选形式(optional form)as?,返回一个你试图下转成的类型的可选值(optional value).强转类型as把试图向下转型和强制解包(force-unwraps)结果作为一个混合动作。
*/

for item in library
{
    if let movie = item as? Movie
    {
        println("Movie: '\(movie.name)', dir. \(movie.director)")
    }
    else if let song = item as? Song
    {
        println("Song: '\(song.name)', by \(song.artist)")
    }
}

/*
注意：转换没有真的改变实例或它的值。潜在的根本的实例保持不变；只是简单的把他作为它被转换成的类来使用。
*/

//Any和AnyObject的转换
/*
Swift为不确定类型提供了两个特殊类型的别名
1.AnyObject可以代表任何class类型的实例
2.Any可以表示任何类型，除了方法类型(function types)

注意：只有当你明确的需要它的行为和功能时才使用Any和AnyObject。在你的代码里使用你期望的明确的类型总是好的
*/

//AnyObject类型
let someObjects: [AnyObject] = [
    Movie(name: "2001:A Space Odyssey", director: "Standley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott"),
]

for object in someObjects
{
    let movie = object as Movie
    println("Movie: '\(movie.name)', dir. \(movie.director)")
}

//更短的形式
for movie in someObjects as [Movie]
{
    println("Movie: '\(movie.name)', dir. \(movie.director)")
}

//Any类型
/*
使用Any类型来和混合的不同类型一起工作，包括非class类型。它创建了一个可以存储Any类型的数组things
*/

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0,5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))

for thing in things
{
    switch thing
    {
        case 0 as Int:
            println("zero as an Int")
        case 0 as Double:
            println("zero as an Double")
        case let someInt as Int:
            println("an integer value of \(someInt)")
        case let someDouble as Double where someDouble > 0:
            println("a positive doule value of \(someDouble)")
        case is Double:
            println("some other double value that don't want to print")
        case let someString as String:
            println("a string value of \"\(someString)\"")
        case let (x,y) as (Double, Double):
            println("an (x,y) point at \(x),\(y)")
        case let movie as Movie:
            println("a movie called '\(movie.name)', dir. \(movie.director)")
        default:
            println("something else")
    }
}





















