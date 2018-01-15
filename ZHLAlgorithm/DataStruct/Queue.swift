//
//  Queue.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/10/27.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit

//MARK: 数组实现
struct Queue1<T> {
    fileprivate var array = [T]()
    
    
    mutating func enqueue(_ element:T){
        array.append(element)
    }
    
    mutating func dequeue() -> T?{
        if isEmpty{
            return nil
        }else{
            return array.removeFirst()
        }
    }
    
//    optimized
    
}

extension Queue1{//MARK:get
    var count:Int{
        return array.count
    }
    var isEmpty:Bool{
        return count == 0
    }
    var front:T?{
        return array.first
    }
}
//MARK: 数组实现  //    optimized
struct Queue2<T> {
    fileprivate var array = [T?]()
    fileprivate var head = 0
    
    
    mutating func enqueue(_ element:T){
        array.append(element)
    }
    
    mutating func dequeue() -> T?{
        if head < array.count,
            let value = array[head]{
            array[head] = nil
            head += 1
            
            
            ///     var bugs = ["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]
            ///     bugs.removeFirst(3)
            ///     print(bugs)
            ///     // Prints "["Damselfly", "Earwig"]"

            if Double(head)/Double(array.count) > 0.25 || array.count > 50{
                array.removeFirst(head)
                head = 0
            }
            return value
        }else{
            return nil
        }
    }
    
    
    
}

extension Queue2{//MARK:get
    var count:Int{
        return array.count - head
    }
    var isEmpty:Bool{
        return count == 0
    }
    var front:T?{
        if isEmpty{
            return nil
            
        }else{
            return array[head]
        }
    }
}
extension Queue2:CustomStringConvertible{
    var description: String{
        return array.description
    }
}

// MARK:链表实现  不怎么好，查询太慢
//  root -> node ->node
struct Queue3<T> {
    public var root:Node<T>?
    fileprivate(set) var count = 0
    
    mutating func enqueue(_ element:T){
        let newNode = Node(element)
        
        if var curr = root{
            
            while curr.next != nil{
                curr = curr.next!
            }
            curr.next = newNode
        }else{
            root = newNode
        }
        
        count += 1
    }
    
    mutating func dequeue()->T?{
        guard let curr = root else{
            return nil
        }
        root = curr.next
        count -= 1
        return curr.value
//        if let curr = root{
//            root = curr.next
//            count -= 1
//            return curr.value
//        }else{
//            return nil
//        }
        
    }
    
}
extension Queue3{//MARK:get
    var isEmpty:Bool{
        return count == 0
    }
    var front:T?{
        return root?.value
    }
}
extension Queue3: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self //拷贝一份
        return AnyIterator {
            return curr.dequeue()
        }
    }
}
extension Queue3:CustomStringConvertible{
    var description: String{
        return Array(self).description
    }
}














