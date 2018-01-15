//
//  Heap.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/11/6.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit


/// 最小堆
struct Heap<T:Comparable> {
     var elements = [T]()
    
    //    MARK:get
    var count:Int{
        return elements.count
    }
    var isEmpty:Bool{
        return count == 0
    }
    public func peek() -> T? {
        return elements.first
    }

    public init(){
        
    }
    public init(array:Array<T>) {
        self.init()
        buildHeap(fromArray: array)
    }
    
    mutating func buildHeap(fromArray array:[T]){
        elements = array
//        insert 0..< count 太慢
//        so 所有的parent Node shiftDown
        for i in stride(from: count/2 - 1, through: 0, by: -1){
            shiftDown(i)
        }
    }
    
    
// 注意使用内联
    @inline(__always)
    func leftChildIndex(ofIndex i:Int) -> Int{
        return i * 2 + 1
    }
    @inline(__always)
    func rightChildIndex(ofIndex i:Int) -> Int{
        return i * 2 + 2
    }

    @inline(__always)
    func parentIndex(ofIndex i:Int) -> Int{
        //    根结点没有parent
//        assert(i > 0)
        return (i - 1) / 2
    }
    
//          0
//        1   2
//       3 4 5 6
    //  -1
    
    mutating func shiftUp(_ index:Int){
        guard index > 0 else {
            return
        }
        var index = index
        var pIndex = parentIndex(ofIndex: index)
        while index > 0, elements[index] < elements[pIndex] {
//            交换效率会低一点，可用变量保存初始值， 最后交换初始值
            elements.swapAt(index, pIndex)
            index = pIndex
            pIndex = parentIndex(ofIndex: index)
        }
    }
    
    
    
    
    public mutating func insert(_ value:T){
        elements.append(value)
        shiftUp(elements.count - 1)
    }
    
    public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T{
        for value in sequence{
            insert(value)
        }
    }
    
    
    

    //          0 -->  6
    //        1   2
    //       3 4 5 6 -->0

    mutating func shiftDown(_ index:Int){
        shiftDown(index, heapSize: count)
    }
    
    
//    对前heapSize 个数据进行shiftDown处理
    mutating func shiftDown(_ index:Int,heapSize:Int){
        var index = index
        
        while true {
            
            let lcIndex = leftChildIndex(ofIndex: index)
            let rcIndex = rightChildIndex(ofIndex: index)
            
//          比较 lcIndex 与 rcIndex 的问题出在 ，不一定有rcIndex
//
//            let min = elements[index]
            var minIndex =  index
            
            if lcIndex < heapSize ,elements[lcIndex] < elements[minIndex]{
                minIndex = lcIndex
            }
            if rcIndex < heapSize, elements[rcIndex] < elements[minIndex]{
                minIndex = rcIndex
            }
            
            if minIndex == index{
                break
            }else{
                elements.swapAt(minIndex, index)
                index = minIndex
            }
        }
    }
 
    @discardableResult
//    Removes the root node from the heap
    public mutating func remove() -> T?{
        if elements.isEmpty{
            return nil
        }else if elements.count == 1 {
            return elements.removeLast()
        }else{
            let value = elements[0]
            elements[0] = elements.removeLast()
            shiftDown(0)
            return value
        }
    }
    
    //          0
    //     6<--1   2
    //       3 4 5 6--->1

    @discardableResult
    public mutating func remove(at index:Int) -> T?{
        guard index < count  else{// count==0 return 0
            return nil
        }

        
//               1
//          2          3
//       4    5     16     7
//      8 9 10 11  17 118  14 15
//
        if index !=  count - 1{
            elements.swapAt(index, count - 1)
            shiftDown(index, heapSize: count - 1)
            
//             MARK:我觉得可以不加，但是测试的不加会有问题，但是我拿到那个数据再去测试，又没问题了，好奇怪  后来才发现
//           当 index 与 lastInex处于同一级,需要shiftUp，也有其它很多情况，开始考虑不全
            shiftUp(index)
            
        }
        return elements.removeLast()
    }
    
    
}



//MARK:sort
extension Heap{
    //               3
    //          2          16
    //       4    5     7     1

//    取出root 放在末尾，然后 n-1 为堆  与remove类似
     mutating func sort() -> [T]{
        for i in stride(from: count - 1, through: 1, by: -1){
            elements.swapAt(0, i)
            shiftDown(0, heapSize: i)
        }
        return elements
    }
}












