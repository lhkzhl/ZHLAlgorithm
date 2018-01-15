//
//  LinkList.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/10/30.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit

final class LinkedList<T> {
    //    MARK:LinkedListNode
    class LinkedListNode<T> {
        weak var previous:LinkedListNode?
        var next:LinkedListNode?
        var value:T
        init(_ value:T) {
            self.value = value
        }
    }
    typealias Node = LinkedListNode<T>


    fileprivate var head: Node?


    
    public subscript(index:Int) -> T{
        let node = self.node(at: index)
        assert(node != nil)
        return node!.value
    }
    
    
    func node(at index:Int)->Node?{
        if index >= 0 {
            var node = head
            var curr = 0
            while node != nil{
                if index == curr {
                    return node
                }
                node = node!.next
                curr += 1
            }
        }
        return nil
    }
    
    func append(_ value:T){
        let node = Node(value)
        self.append(node)
    }
    
    func append(_ node:Node){
        if let lastNode = last{
            lastNode.next = node
            node.previous = lastNode
        }else{
            head = node
        }
    }
    
    func nodeBeforeAndAfter(index:Int) -> (Node?,Node?){
        assert(index >= 0)
        
        var index = index
        var prev:Node?
        var next = head
        
        while next != nil,index > 0 {
            index -= 1
            prev = next
            next = next?.next
        }
        
        // if > 0, then specified index was too large
        assert(index == 0)
        return (prev,next)
    }
    
    func insert(_ value:T,at index:Int){
        let node = Node(value)
        self.insert(node, at: index)
    }
    func insert(_ node:Node,at index:Int){
        let (prev,next) = nodeBeforeAndAfter(index: index)
        
        prev?.next = node
        node.previous = prev

        node.next = next
        next?.previous = node
        
        if prev == nil{
            head = node
        }
    }
    
    func insert(_ list:LinkedList,at index:Int){
        //        MARK:是否需要拷贝一个新的node?
        if list.isEmpty { return }
        let (prev,next) = nodeBeforeAndAfter(index: index)
        
        list.first?.previous = prev
        prev?.next = list.first
        if prev == nil{
            head = list.first
        }

        list.last?.next = next
        next?.previous = list.last
        
    }

    @discardableResult
    func remove(at index:Int) ->T{
        let node = self.node(at: index)
        assert(node != nil)
        return remove(node: node!)
    }
    @discardableResult
    func remove(node:Node)->T{
        let prev = node.previous
        let next = node.next
        
        if let prev = prev{
            prev.next = next
            next?.previous = prev
        }else{
            head = next
            next?.previous = nil
        }
        
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    @discardableResult
    func removeLast() ->T{
        assert(!isEmpty)
        return remove(node: last!)
    }

    func removeAll(){
//        会不会有问题？  循环引用？
//        head = nil
        
//        效率低下
        while !isEmpty {
            removeLast()
        }
        
    }
    
    
}
//      MARK:get
extension LinkedList{
    var isEmpty:Bool{
        return head == nil
    }
    
    var first:Node?{
        return head
    }
    var last:Node?{
        var node = head
        while node?.next != nil {
            node = node?.next
        }
        return node
    }
    
    //可以加一上变量来计算count，可以优化速度
    var count:Int{
        if var node = head{
            var c = 1
            while let next = node.next{
                node = next
                c += 1
            }
            return c
        }else{
            return 0
        }
    }
}
extension LinkedList:CustomStringConvertible{
    var description: String{
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            
            if node != nil{
                s += ","
            }
        }
        s += "]"
        return s
    }
}

extension LinkedList{
    func reverse(){
        var node = head
        while let curr = node {
            node = node?.next
            swap(&curr.next, &curr.previous)
            head = curr
        }
    }
}

extension LinkedList {
    convenience init(array: Array<T>) {
        self.init()
        for element in array {
            self.append(element)
        }
    }
}

extension LinkedList: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()
        
        for element in elements {
            self.append(element)
        }
    }
}

