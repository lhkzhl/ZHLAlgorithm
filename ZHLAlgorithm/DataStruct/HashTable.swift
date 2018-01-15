//
//  HashTable.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/11/6.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit

//   TODO:Bucket = [Element]  用链表实现
struct HashTable1 <Key:Hashable,Value>{
    private typealias Element = (key:Key,value:Value)
    private typealias Bucket = [Element]
    private var buckets:[Bucket]
    private(set) var count = 0
    
    public init(capacity:Int){
        assert(capacity>0)
        buckets = Array(repeating: [], count: capacity)
    }
    
    //    MARK:get
    public var isEmpty:Bool{
        return count == 0
    }

    
    public subscript(key:Key) -> Value?{
        set{
            if let value = newValue{
                updateValue(value, forKey: key)
            }else{
                removeValue(forKey: key)
            }
        }
        get{
            return value(forKey: key)
        }
    }
    
    
    func index(forKey key:Key) -> Int{
         return abs(key.hashValue) % buckets.count
    }
    
    func value(forKey key:Key) -> Value?{
        let index = self.index(forKey: key)
        let bucket = buckets[index]
        for element in bucket{
            if element.key == key{
                return element.value
            }
        }
        return nil
    }
    
    @discardableResult
    public mutating func updateValue(_ value:Value, forKey key:Key) -> Value?{
        let index = self.index(forKey: key)
        let bucket = buckets[index]
        for (i,element) in bucket.enumerated(){
            if element.key == key{
                let oldElement = element
//                element.value = value
                buckets[index][i].value = value
                return oldElement.value
            }
        }
//      没有找到 添加key,value
        buckets[index].append((key,value))
        count += 1
        return nil
    }
    @discardableResult
    public mutating func removeValue(forKey key:Key) -> Value?{
        let index = self.index(forKey: key)
        let bucket = buckets[index]
        for (i,element) in bucket.enumerated(){
            if element.key == key{
                count -= 1
                return buckets[index].remove(at: i).value
            }
        }
        return nil
    }
    
    public mutating func removeAll(){
        count = 0
        buckets = Array(repeating: [], count: buckets.count)
    }
}

extension HashTable1:CustomStringConvertible{
    var description: String{
        var s = ""
        
        for (i,bucket) in buckets.enumerated(){
            let pairs = bucket.map{
                "\($0.key) = \($0.value)"
            }
            s += "bucket \(i):" + pairs.joined(separator: ",") + "\n"
        }
        return s
    }
}

