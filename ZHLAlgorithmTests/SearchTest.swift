//
//  SearchTest.swift
//  ZHLAlgorithmTests
//
//  Created by hailong on 2017/11/1.
//  Copyright © 2017年 hailong. All rights reserved.
//

import XCTest

@testable import ZHLAlgorithm
extension String{
    func index1(of pattern: String) -> String.Index? {
        for i in self.characters.indices {
            var j = i
            var found = true
            for p in pattern.characters.indices{
//               j == self.length  || 不相等
                if j == self.characters.endIndex || self[j] != pattern[p] {
                    found = false
                    break
                } else {
//                    j += 1
                    j = self.characters.index(after: j)
                    
                }
            }
            if found {
                return i
            }
        }
        return nil
    }
}
func swap<T>(_ nums: inout [T], _ p: Int, _ q: Int) {
    (nums[p], nums[q]) = (nums[q], nums[p])
}
class SearchTest: XCTestCase {
    
    func test(){
        print("123".endIndex)
        let abc = "hello world".index(of: "world")
        print(abc!)
    }
    
    func test2(){
        let abc = "hello world".index(of: "world")
        print(abc)
    }
    
    func address(o: UnsafePointer<Void>) -> String {
        return String.init(format: "%018p", unsafeBitCast(o, to: Int.self))
    }
    func test3(){
      
    
        var a = 5
        print(a,address(o: &a))
        
        
        var view = UIView()
        print(view,address(o: &view))
    }
}

extension String{
//    func index
}
