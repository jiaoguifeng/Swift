//
//  main.swift
//  2.9
//
//  Created by jiaoguifeng on 11/17/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 类和结构体 */
/*
类和结构体是人们构造代码所用的一种通用且灵活的结构体。
与其他变成语言不同，Swift并不要求你为自定义类和结构体去创建独立的接口和实现文件，你所要做的是在一个单一文件中定义一个类或者结构体，系统将自动生成面向其他代码的外部接口
注意：通常一个类的实例被成为对象。然而在Swift中，类和结构体的关系要比在其他语言中更加的密切，本章所讨论的大部分功能都可以用在类和结构体上。因此，我们会主要使用实例而不是对象
*/

//类和结构体对比
/*
Swift中类和结构体有很多共同点：
1.定义属性用于存储值
2.定义方法用于提供功能
3.定义下标用于通过下标语法访问值
4.定义初始化器用于生成初始化值
5.通过扩展以增加默认实现的功能
6.符合协议以对某类提供标准功能

与结构体相比，类还有如下的附加功能：
1.继承允许一个类继承另一个类的特征
2.类型转换允许在运行时检查和解释一个类实例的类型
3.取消初始化器允许一个类实例释放任何其所被分配的资源
4.引用计数允许对一个类的都次引用


注意：结构体总是通过被复制的方式在代码中传递，因此请不要使用引用计数

类和结构体有着类似的定义方式。我们通过关键字class和struct来分别表示类和结构体，并在一个对大括号中定义他们的具体内容
*/

struct Resolution
{
    var width = 0
    var height = 0
}

class VideoMode
{
    var resolution = Resolution()
    var interfaced = false
    var fremeRate = 0.0
    var name : String?
}

//生成结构体和类实例的语法非常相似
let someResolution = Resolution()
let someVideoMode = VideoMode()

//访问属性
   //通过使用点语法(dot syntax),你可以访问实例中所含有的属性。其语法规则是，实例名后面紧跟属性名，两者通过点号(.)链接：
println("The width of someResolution is \(someResolution.width)")
println("The width of someVideoMode is now \(someVideoMode.resolution.width)")

let vga = Resolution(width: 640, height: 480) //所有结构体都有一个自动生成的成员逐一初始化器，用于初始化新结构体实例中成员的属性，新实例中各个属性的初始值可以通过属性的名称传递到成员逐一初始化器之中

//与结构体不同，类实例没有默认的成员逐一初始化器，构造过程章节会对初始化器进行详细的讨论

//结构体和枚举是值类型：值类型被赋予给一个变量，常量或者本身被传递给一个函数的时候，实际上操作的是其的拷贝

//实际上，在Swift中，所有的基本类型：整数(Integer),浮点数(float-point),布尔值(Booleans),字符串(string),数组(array)和字典(dictionary),都是值类型，并且都是以结构体的形式在后台所实现的。

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd  //cinema的值其实是hd的一个拷贝副本，而不是hd本身

cinema.width = 2048
println("cinema is now \(cinema.width) pixels wide")
println("hd is now \(hd.width) pixels wide")

//类是引用类型
   //与值类型不同，引用类型在被赋予一个变量后，常量或者被传递到一个函数是，操作的并不是其拷贝，因此，引用的是已存在的实例本身而不是其拷贝。

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interfaced = false
tenEighty.name = "1080i"
tenEighty.fremeRate = 25

let alsoTenEighty = tenEighty  //引用类型，所以alsoTenEighty和tenEighty实际上引用的是相同的VideoMode实例

/*
需要注意的是alsoTenEighty和tenEighty被声明为常量(constants)而不是变量，然而你依然可以改变tenEighty.fremeRate和alsoTenEighty.fremeRate，这是因为常量本身不会改变，他们并不存储这个VideoMode实例，在后台仅仅是对VideoMode实例的引用。所以，改变的是被引用的基础VideoMode的frameRate参数，而不改变常量的值
*/

//恒等运算符
/*
因为类是引用类型，有可能有多个常量或者变量在后台同时引用某一个类实例(结构体和枚举例外，因为他们是值类型，做拷贝操作)，如果能够判定两个常量或者变量是否引用同一个类实例很有帮助，为了达到这个目的，Swift内建了两个恒等运算符：等价于(===),不等价于(!==)
*/
if tenEighty === alsoTenEighty //表示两个类类型(classType)的常量或者变量引用同一个类实例。
{
    println("tenEighty and alsoTenEighty refer to the same resolution instance")
}

//指针
/*
如果你有C,C++或者objective-c语言的经验，那么你也许会知道这些语言使用指针来引用内存中的地址。一个Swift常量或者变量引用一个引用类型的实例与C语言中的指针类似，不同的是并不直接指向内存中的某个地址，而且也不需要你使用星号(*)来表明你在创建一个引用。Swift中这些引用与其他的常量或者变量的定义方式相同。

结构体实例总是通过值传递，类实例总是通过引用传递。
*/

//集合(Collection)类型的赋值和拷贝行为
/*
Swift中字串(String),数组(Array)和字典(Dictionary)类型均以结构体的形式出现。然而当数组被赋予一个常量或者变量，或被传递给一个函数或方法时，拷贝行为发生。

Swift中字串(String),数组(Array)和字典(Dictionary)和Foundation中NSString,NSArray,NSDictionary有所不同，后者是以类的形式出现，前者是以结构体的形式出现，NSString,NSArray,NSDictionary实例总是以对已有实例引用，而不是拷贝的方式被赋值和传递
*/
var ages = ["Peter":23,"Wei":35,"Anish":65,"Katya":19]
var copiedAges = ages

copiedAges["Peter"] = 24
println(ages["Peter"])

var a = [1,2,3]
var b = a
var c = a
//a,b,c完全一致

a[0] = 42
println(a[0])
println(b[0])
println(c[0])
println("-----------8---")

