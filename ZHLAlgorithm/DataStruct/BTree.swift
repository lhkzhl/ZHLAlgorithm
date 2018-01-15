//
//  BTree.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/11/12.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit

class BTree<Key:Comparable,Value> {

    class BTreeNode<Key:Comparable,Value> {
        unowned var owner:BTree<Key,Value>
        fileprivate var keys = [Key]()
        fileprivate var values = [Value]()
        var children:[BTreeNode]?
        
        //        MARK:get
        var isLeaf:Bool{
            return children == nil
        }
        var numberOfKeys:Int{
            return keys.count
        }
        init(owner:BTree<Key,Value>) {
            self.owner = owner
        }
        convenience init(owner:BTree<Key,Value>,keys:[Key],
                         values:[Value],children:[BTreeNode]? = nil) {
            self.init(owner: owner)
            self.keys += keys
            self.values += values
            self.children = children
        }
    
        func value(for key:Key) -> Value?{
            var index = keys.startIndex
            
            while (index + 1) < keys.endIndex &&
                keys[index] < key{
                index += 1
            }
            if key == keys[index]{
                return values[index]
            }else if key < keys[index]{
                return children?[index].value(for: key)
            }else {
                return children?[index + 1].value(for: key)
            }
        }
        
        func traverseKeysInOrder(_ process:(Key)->Void){
            for i in 0..<numberOfKeys{
                children?[i].traverseKeysInOrder(process)
                process(keys[i])
            }
            children?.last?.traverseKeysInOrder(process)
        }
    
        func insert(_ value:Value,for key:Key){
            var index = keys.startIndex
            while index < keys.endIndex && keys[index] < key {
                index = (index + 1)
            }
            if index < keys.endIndex && keys[index] == key{
                values[index] = value
                return
            }
            
            if isLeaf{
                keys.insert(key, at: index)
                values.insert(value, at: index)
                owner.numberOfkeys += 1
            }else{
                children![index].insert(value, for: key)
//                if children![index].numberOfKeys > owner.or
            }
            
        }
    }

    typealias Node = BTreeNode<Key,Value>
    
    
    public let order:Int
    
    var rootNode:Node!
    
    fileprivate(set) public var numberOfkeys = 0
    
    
    public init?(order:Int){
        guard order > 0 else{
            print("Order has to be greater than 0")
            return nil
        }
        self.order = order
        rootNode = Node(owner: self)
    }
    
    
    func traverseKeysInOrder(_ process:(Key)->Void){
        rootNode.traverseKeysInOrder(process)
    }
    public subscript(key:Key) -> Value?{
        return value(for: key)
    }

    
    public func value(for key:Key) -> Value?{
        guard rootNode.numberOfKeys > 0 else{
            return nil
        }
        return rootNode.value(for: key)
    }
    
    public func insert(_ value:Value,for key:Key){
        rootNode.insert(value, for: key)
        
        if rootNode.numberOfKeys > order * 2{
            
        }
    }
    
    public func remove(_ key:Key){
        guard rootNode.numberOfKeys > 0 else{
            return
        }
//        rootNode.
    }
}
