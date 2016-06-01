//
//  main.swift
//  2.12
//
//  Created by jiaoguifeng on 12/22/14.
//  Copyright (c) 2014 jiaoguifeng. All rights reserved.
//

import Foundation

/* 附属脚本 */
/* 附属脚本可以定义在类(class)、结构体(structure)和枚举(enumeration)这些目标中，可以认为是访问对象、集合或序列的快捷方式，不需要在调用实例的特定的赋值和访问方法。*/

//附属脚本语法
/* 附属脚本允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。语法类似于实例方法和计算型属性的混合*/

struct TimesTable
{
    let multiplier: Int
    subscript(index: Int) -> Int
    {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)   //初始化
println("3的6倍是\(threeTimesTable[6])")  //threeTimesTable[6] 调用脚本 subscript(index: Int) -> Int

//附属脚本用法
var numberOfLegs = ["spider" : 8, "ant" : 6, "cat" : 4]
numberOfLegs["bird"] = 2
/* Swift中字典的附属脚本实现中，在get部分返回值是Int?,上例中的numberOfLegs字典通过下边返回的是一个Int?或者说“可选的Int”，不是每个字典的索引都能得到一个整数值，对于没有设过值的访问返回的结果就是nil，同样想要从字典实例中删除某个索引下的值也只需要给这个索引赋值为nil即可*/

//附属脚本选项
struct Matrix
{
    let rows: Int,columns:Int
    var grid: [Double]
    init(rows: Int,columns: Int)
    {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns,repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool
    {
        return row >= 0 &&  row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int,column: Int) -> Double
    {
        get{
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        
        set{
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
println(matrix.grid)

matrix[0,1] = 1.5
matrix[1,0] = 3.2

println(matrix.grid)

//let someValue = matrix[2,2]  //会触发断言 因为[2,2]已经超越了matrix的最大长度。assertion failed: Index out of range



