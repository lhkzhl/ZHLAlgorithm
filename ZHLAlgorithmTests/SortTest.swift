//
//  SortTest.swift
//  ZHLAlgorithmTests
//
//  Created by hailong on 2017/11/2.
//  Copyright © 2017年 hailong. All rights reserved.
//

import XCTest
@testable import ZHLAlgorithm

class SortTest: XCTestCase {
    private func buildRandomArray() -> [UInt32]{
        var array = [UInt32]()
        for _ in 0...20{
            array.append(arc4random()%20)
        }
        return array
    }
    private func isSortedArray<T:Comparable>(array:[T])->Bool{
        for i in 1..<array.count{
            if array[i-1]>array[i]{
                return false
            }
        }
        return true
    }
    
    func testBuble(){
        var array = buildRandomArray()
        bubbleSort(&array)
        XCTAssertTrue(isSortedArray(array: array))
        
    }
    func testBuble2(){
        var array = buildRandomArray()
        bubbleSort2(&array)
        XCTAssertTrue(isSortedArray(array: array))
    }
    func testInsert(){
        var array = buildRandomArray()
        insertSort(&array)
        XCTAssertTrue(isSortedArray(array: array))
    }
    func testInsert2(){
        var array = buildRandomArray()
        insertSort2(&array)
        XCTAssertTrue(isSortedArray(array: array))
    }

    func testMergeSort(){
        var array = buildRandomArray()
        print(array)
        
        mergeSort(&array)
        print(array)
        XCTAssertTrue(isSortedArray(array: array))
    }
    
    func testMergeSort2(){
        var array = buildRandomArray()
        print(array)
        mergeSort2(&array)
        print(array)
        XCTAssertTrue(isSortedArray(array: array))
    }
    func testSelectSort(){
        var array = buildRandomArray()
        print(array)
        selectSort(&array)
        print(array)
        XCTAssertTrue(isSortedArray(array: array))
    }
    func testQuickSort(){

        
        var array = buildRandomArray()
        print(array)
        quickSort(&array)
        print(array)
        
        print([1,3].binarySearch(3) ?? "nil")
        XCTAssertTrue(isSortedArray(array: array))
    }
    
    func testHeapSort(){
        
        
        var array = buildRandomArray()
        print(array)
        heapSort(&array)
        print(array)
        
    }

}


extension Optional where Wrapped:CustomStringConvertible{
    func print()-> String{
        return self?.description ?? ""
    }
}
