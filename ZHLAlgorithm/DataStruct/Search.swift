//
//  Search.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/11/2.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit




extension Array where Element: Comparable{
    func binarySearch(_ element:Element)->Int?{
        var low = 0
        var high = count - 1
        while low <= high {
            let middle = low + (high - low)/2
            if  element < self[middle]{
                high = middle - 1
            }else if element > self[middle]{
                low = middle + 1
            }else{
                return middle
            }
        }
        return nil
    }
}

extension String{
//    let abc = "hello world".index(of: "word")
    func index(of pattern:String) -> Index?{
        for c in self.indices{
//             if self[index] == pattern[self]
            var temp = c
            var isFound = false
            for p in pattern.indices{
                if pattern[p] == self[temp] ,
                    p != pattern.endIndex{
                    temp = index(after: temp)
                    isFound = true
                }else
                {
                    isFound = false
                    break;
                }
            }
            if isFound == true{
                return c
            }
        }
        return nil
    }
}





