//
//  Sort.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/11/2.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit

public func bubbleSort<T:Comparable>(_  array:inout [T]){
    let count = array.count
    for i in 0..<count{
        for j in 0..<(count-i-1){
            if array[j] > array[j+1]{
//                array.swapAt(j, j+1)
                let temp = array[j]
                array[j] = array[j+1]
                array[j+1] = temp
            }
        }
    }
}

public func bubbleSort2<T:Comparable>(_  array:inout [T]){
    var count = array.count
    var isSwaped = false
    repeat{
        isSwaped = false
        for j in 1..<count{
            if array[j-1] > array[j]{
                array.swapAt(j-1, j)
                isSwaped = true
            }
        }
        count -= 1
    }while(isSwaped)
}
public func insertSort<T:Comparable>(_  array:inout [T]){
//    5,4,3,1,2
//     4 5 312
//
    for i in 1..<array.count{
        var index  = i
        let temp = array[i]
      
        for j in stride(from: i-1, to: -1, by: -1){//to -1:不包含-1
            if array[j] > temp{
                array[j+1] = array[j]
                index = j
            }
        }
        array[index] = temp
    }
}

public func insertSort2<T:Comparable>(_  array:inout [T]){
    //    5,4,3,1,2
    //     4 5 312
    //
    for i in 1..<array.count{
        var j  = i-1
        let temp = array[i]
        
//        while j>=0{
//            if array[j] > temp{
//                array[j+1] = array[j]
//                j -= 1
//            }else{
//                break
//            }
//        }
//        array[j+1] = temp
        
        while j>=0,
            array[j] > temp{
                array[j+1] = array[j]
                j -= 1
        }
        array[j+1] = temp
    }
}

func mergeSort<T:Comparable>(_ array:[T])->[T]{
    guard array.count > 1 else {
        return array
    }
    let middle = array.count/2
    let left = mergeSort(Array(array[0..<middle]))
    let rihgt = mergeSort(Array(array[middle..<array.count]))
    return merge(left: left, right: rihgt)
}

func merge<T:Comparable>( left:[T], right:[T])->[T]{
    
//    l  1346
//    r  3456
    var l = 0
    var r = 0
    var array = [T]()
    if array.capacity < left.count + right.count{
        array.reserveCapacity(left.count + right.count)
    }
//    先把一个数组加完
    while l < left.count && r < right.count {
        if left[l] < right[r]{
            array.append(left[l])
            print(left[l],right[r],array)
            l += 1
        }else if right[r] < left[l]{
            array.append(right[r])
            print(left[l],right[r],array)
            r += 1
        }
        else{ //相等加两个
            array.append(left[l])
            
            l += 1
            array.append(right[r])
            print(left[l-1],right[r],array)
            r += 1
        }
        
    }
//    拼接剩下没加完的数组
    while l < left.count {
        array.append(left[l])
        l += 1
    }
    while r < right.count {
        array.append(right[r])
        r += 1
    }
    
    print("left:\(left)  right:\(right)  array:\(array)")
    return array
}
func mergeSort<T:Comparable>(_ array:inout [T]){
    array = mergeSort(array)
}

func mergeSort2<T:Comparable>(_ array:inout [T]){
    let count = array.count
    var z = [array,array] // 二维数组
//    width = 1  ,z[d] ->z[1-d]  ,width*2 交换  z[1-d] ->z[d]
//    数组之间交换 和上一个的 新建数组拼接相比较
    var d = 0 //z[d] is used for reading, z[1 - d] for writing
    var width = 1
    
    
    while width < count {
        var i = 0
        while i < count{ // i += width *2 ,注意这里width *2表示 left -width- right-width ,left 和right的length
            var j = i       //i 有用，用j来代替
            var l = i      //left
            var r = i + width //right
            
            let lMax = min(l+width, count)
            let rMax = min(r+width, count)
            
            while l<lMax,r<rMax{
                if z[d][l] < z[d][r]{
                    z[1-d][j] = z[d][l]
                    l += 1
                }else{
                    z[1-d][j] = z[d][r]
                    r += 1
                }
                j += 1
            }
            while l < lMax{
                z[1-d][j] = z[d][l]
                j += 1
                l += 1
            }
            
            while r < rMax{
                z[1-d][j] = z[d][r]
                j += 1
                r += 1
            }
            i += width * 2
        }
        width *= 2
        d = 1-d
        print("arr:",z)
    }
    array = z[d]
}

//  选择最小的放在最前面，
func selectSort<T:Comparable>(_ array:inout [T]){
    for i  in 0 ..< array.count - 1 {
//        var min = array[i]
        var minIndex = i
        for j in (i+1)..<array.count{
            if array[j] < array[minIndex]{
//                min = array[j]
                minIndex = j
            }
        }
        array.swapAt(i, minIndex)
    }
}

func quickSort<T:Comparable>(_ array: [T]) -> [T]{
    guard array.count > 0 else {
        return array
    }
    let middle = array[array.count/2]
    
    let lower = array.filter { (element) -> Bool in
        element < middle
    }
    let equal = array.filter { (element) -> Bool in
        element == middle
    }
    let higher = array.filter { (element) -> Bool in
        element > middle
    }
    
    return quickSort(lower) + equal + quickSort(higher)
}
func quickSort<T:Comparable>(_ array:inout [T]){
    array = quickSort(array)
}


func heapSort<T:Comparable>(_ array:inout [T]){
    var h = Heap(array: array) //最小堆 得出的是最 大->小（小的在末尾）
    array = h.sort().reversed()
}
