//
//  HashTableTest.swift
//  ZHLAlgorithmTests
//
//  Created by hailong on 2017/11/6.
//  Copyright © 2017年 hailong. All rights reserved.
//

import XCTest
@testable import ZHLAlgorithm
class HashTableTest: XCTestCase {
    func test(){
        print("firstName".hashValue)
        print(abs("firstName".hashValue) % 5)
        
     
        
        // Playing with the hash table
        
        var hashTable = HashTable1<String, String>(capacity: 5)
        
        hashTable["firstName"] = "Steve"
        hashTable["lastName"] = "Jobs"
        hashTable["hobbies"] = "Programming Swift"
        
        print(hashTable)
        print(hashTable)
        
        let x = hashTable["firstName"]
        print(x!)
        hashTable["firstName"] = "Tim"
        
        let y = hashTable["firstName"]
        print(y!)
        hashTable["firstName"] = nil
        
        let z = hashTable["firstName"]
        print(z ?? "nil")
        print(hashTable)
        print(hashTable)

    }
}
