//
//  main.swift
//  2.2
//
//  Created by jiaoguifeng on 11/4/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 基本运算符 */
   //运算符是检查，改变，合并值的特殊符号或者短语

var str = "hello" + " World"
println(str)

let dog: Character = "d"
let cow: Character = "c"
//let dogcow = dog + cow;  文档原文，编译错误，估计为系统bug

println(-9%4)

  //当 ++ 前置的时候，先自增再返回；当 ++ 后置的时候，先返回在自增
var a = 0
let b = ++a   //a 和 b 现在都是1
let c = a++   //a现在是2，但c是a自增前的值1

var m = 1
m += 2
   //m += 2 是 m = m + 2的简写
   //注意双目运算符没有返回值，let b = a += 2这类代码是错误的

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

 //区间运算符
 //a...b定义了包含从a到b（包括a和b）的所有值的区间
 //半闭空间运算符
 //a..b定义了从a到b但不包含b的区间

