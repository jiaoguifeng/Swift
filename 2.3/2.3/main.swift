//
//  main.swift
//  2.3
//
//  Created by jiaoguifeng on 11/4/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 字符串和字符 */

//String是一个有序的字符集合，Swift字符串通过String类型来表示，也可以表示为Character类型值的集合

/* 
注意：Swift的String类型与Foundation NSString类型进行了无缝桥接，如果您利用Cocoa或Cocoa Touch中的Foundation框架进行工作，整个NSString API都可以调用您创建的任意String类型的值，除了本章介绍的String特性。您也可以在任意要求传入NSString实例作为参数的API中使用String类型的值进行替换
*/

/*
1.转义特殊字符 \0(空字符)、\\(反斜杠)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
2.单字节Unicode标量，写成\xnn,其中nn为两位十六进制数
3.双字节Unicode标量，写成\unnnn,其中nnnn为四位十六进制数
4.四字节Unicode标量，写成\Unnnnnnnn,其中nnnnnnnn为八位十六进制数
*/

let wiseWord = "\" Imagination is more important than knowledge\" - Einstein"
//let dollarSign = "\x24"
//let blackHeart = "\u2665"
//let sparklingHeart = "\UOOO1F496"  这个是bug，报错，无法编译

/* 1.初始化空字符串 */
var emptyString = ""
var anotherEmptyString = String() //initializer syntax
   //这两个字符串都为空，并且两者等价

 //可以通过检查其Boolean类型的isEmpty属性来判断该字符串是否为空
if  emptyString.isEmpty
{
    println("Nothing to see here")
}

/* 2.字符串可变性 */

/* 
注意：在objective-c和cocoa中，您可以通过选择两种不同的类(NSString 和 NSMutableString)来指定该字符串是否可以被修改，Swift中的字符串是否可以被修改仅通过定义的是常量还是变量来决定，实现多种类型可变性操作的统一
*/

/*
Swift的String类型是值类型，如果您创建了一个新的字符串值，那么当其进行常量，变量赋值操作或在函数/方法中传递时，会进行值拷贝。在不同情况下，都会对已有字符串值创建新副本，并对该副本进行传递或赋值

注意：和Cocoa中的NSString不同，当您在Cocoa中创建了一个NSString实例，并将其传递给一个函数/方法，或者赋给一个变量时，您永远都是传递或赋值同一个NSString实例的一个引用。除非您特别要求其进行拷贝，否则字符串不会进行赋值新副本操作
*/

/* 3.使用字符(Characters) */
for character in "Dog!????"
{
    println(character)
}

let unusualMenagerie = "Koala??,fjdjfldfjldfjleifdlfjldjfeifldjflddlfldm,dfldjlfj,fdf;dfmmdsfmdmfmdf.dlf.df.df"
println("unusualMenagerie has \(countElements(unusualMenagerie)) characters")
   //全局函数countElements()，统计字符数量

















