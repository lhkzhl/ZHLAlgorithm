//
//  BinarySearchTree.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/11/8.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit

class BinarySearchTree<T:Comparable> {
    fileprivate typealias Tree = BinarySearchTree<T>
    fileprivate(set) public var value:T
    fileprivate(set) public var parent:BinarySearchTree?
    fileprivate(set) public var left:BinarySearchTree?{
        didSet{
            left?.parent = self
        }
    }
    fileprivate(set) public var right:BinarySearchTree?{
        didSet{
            right?.parent = self
        }
    }
    
    init(value:T) {
        self.value = value
    }
    init(array:[T]){
        precondition(array.count > 0)
        self.value = array.first!
        for i in array.dropFirst(){
            insert(value: i)
        }
    }
    
    //    MARK:get
    public var isRoot:Bool{
        return parent == nil
    }
    public var isLeftChild:Bool{
        return parent?.left === self
    }
    public var isRightChild:Bool{
        return parent?.right === self
    }
    public var isLeaf:Bool{
        return left == nil && right == nil
    }

    public var hasLeftChild:Bool{
        return left != nil
    }
    public var hasRightChild:Bool{
        return right != nil
    }
    public var hasAnyChild:Bool{
        return hasLeftChild || hasRightChild
    }
    public var hasBothChild:Bool{
        return hasLeftChild && hasRightChild
    }
    public var count:Int{
        return (left?.count ?? 0) + (right?.count ?? 0) + 1
    }
}

//Searching
extension BinarySearchTree{
    
    public func search(value:T) -> BinarySearchTree?{
        var node:BinarySearchTree? = self
        while node != nil {
            if value < node!.value{
                node = node?.left
            }else if value > node!.value{
                node = node?.right
            }else{
                return node
            }
        }
        return nil
    }
    public func contain(value:T) -> Bool{
        return search(value: value) != nil
    }
    
    public func minimum() -> BinarySearchTree{
        if let left = left{
            return left.minimum()
        }
        return self
    }
    
    public func maximum() -> BinarySearchTree{
        return right?.maximum() ?? self
    }
    
//    the distance to the root.
    public func depth() -> Int{
        if let p = parent{
            return p.depth() + 1
        }
        return 0
    }
    
//    the distance to the lowest leaf.
    public func height() -> Int{
        if isLeaf{
            return 0
        }
        return max(left?.height() ?? 0, right?.height() ?? 0) + 1
    }
    
}
// MARK:Modify items
extension BinarySearchTree{
    public func insert(value:T){
        if value < self.value{
            if let left = left{
                left.insert(value: value)
            }else{
                left = Tree(value: value)
            }
        }else{
            if let right = right{
                right.insert(value: value)
            }else{
                right = Tree(value: value)
            }
        }
    }
    
    
    /// remove root  delete left max/riht min
    @discardableResult
    public func remove() -> BinarySearchTree?{
//  1. find replaceNode
//  2.  replace remove from tree （递归思想，难点在这里，会先清除replaceNode）
//  3.  replace.left right parent , parent.left/right
//  4.  self.left right paren ->nil
        var tree:Tree? = nil
        if let right = right{
            tree = right.minimum()
        }else if let left = left{
            tree = left.maximum()
        }
        
        // replaceNode remove
        tree?.remove()
        
        tree?.left = left
        tree?.right = right
        
//
        if let parent = parent {
            if  isLeftChild {
                parent.left = tree
            }else if isRightChild{
                parent.right = tree
            }
        }
        tree?.parent = parent
        
        left = nil
        right = nil
        parent = nil
        return tree
    }
}

// MARK: - Traversal
extension BinarySearchTree{
    public func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }
    public func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    public func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }
}

extension BinarySearchTree{
//   left.max  ,parent,及p.parent 都可能比self 小
//  这个还是有问题：  但，parent < self， 从insert 来看，如果self.left != nil,那么self.left > self.parent
    func predecessor() -> BinarySearchTree?{
        if let left = left{
            return left.maximum()
        }else{
            var node:Tree = self
            while let parent = node.parent{
                if parent.value < node.value{
//                    第一个最小的
                    return parent
                }
                    node = parent
            }
        }
        return nil
    }
    func successor() -> BinarySearchTree?{
        if let right = right{
            return right.minimum()
        }else{
            var node = self
            while let parent = node.parent{
                if parent.value > node.value{
                    return parent
                }
                node = parent
            }
        }
        return nil
    }
}

extension BinarySearchTree{
    func map(formula:(T)->T) -> [T]{
        var a = [T]()
        if let left = left{
            a += left.map(formula: formula)
        }
        a.append(formula(value))
        if let right = right{
            a += right.map(formula: formula)
        }
        return a
    }
    
    func toArray() -> [T]{
        return map{$0}
    }
}

extension BinarySearchTree:CustomStringConvertible{
    var description: String{
        var s = ""
        
        return s
    }
}

