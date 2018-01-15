//
//  Stack.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/10/26.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit

//MARK:数组实现
struct Stack1<T> {

    fileprivate var array:[T] = []
    
    mutating func push(_ element:T){
        array.append(element)
    }
    
    mutating func pop()->T?{
        return array.popLast()
    }
    
}
//    MARK:GET
extension Stack1{
    var count:Int{
        return array.count
    }
    var isEmpty:Bool{
        return count == 0
    }
    var top:T?{
        return array.last
    }
}
extension Stack1: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self //拷贝一份
        return AnyIterator {
            return curr.pop()
        }
    }
}
extension Stack1:CustomStringConvertible{
    var description: String{
        return array.description
    }
}



//MARK:链表实现
struct Stack2<T> {
    fileprivate var root:Node<T>?
    fileprivate(set) var count: Int = 0
    init() {
        
    }
    mutating func push(_ element:T){
        let newRoot = Node(element)
        count += 1
        if let _root = root{
            newRoot.next = _root
            root = newRoot
        }else{
            root = newRoot
        }
      
    }
    
    mutating func pop()->T?{
        if let value = root?.value{
            root =  root?.next
            count -= 1
            return value
        }else{
            return nil
        }
    }
}
//    MArR:GET
extension Stack2{
    var isEmpty:Bool{
        return count == 0
    }
    var top:T?{
        return root?.value
    }
}
extension Stack2: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self //拷贝一份
        return AnyIterator {
            return curr.pop()
        }
    }
}
extension Stack2:CustomStringConvertible{
    var description: String{
        return Array(self).description
//        var s = "["
//        for (index,value) in self.enumerated() {
//            if index == count-1{
//                s += "\(value)"
//            }else{
//                s += "\(value),"
//            }
//        }
//        s += "]"
//        return s
    }
}


