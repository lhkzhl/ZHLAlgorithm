//
//  HeapTest.swift
//  ZHLAlgorithmTests
//
//  Created by hailong on 2017/11/7.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit
import XCTest
@testable import ZHLAlgorithm
class HeapTest: XCTestCase {
    fileprivate func verifyMinHeap(_ h: Heap<Int>) -> Bool {
        for i in 0..<h.count {
            let left = h.leftChildIndex(ofIndex: i)
            let right = h.rightChildIndex(ofIndex: i)
            let parent = h.parentIndex(ofIndex: i)
            if left < h.count && h.elements[i] > h.elements[left] { return false }
            if right < h.count && h.elements[i] > h.elements[right] { return false }
            if i > 0 && h.elements[parent] > h.elements[i] { return false }
        }
        return true
    }
    fileprivate func isPermutation(_ array1: [Int], _ array2: [Int]) -> Bool {
        var a1 = array1
        var a2 = array2
        if a1.count != a2.count { return false }
        while a1.count > 0 {
            if let i = a2.index(of: a1[0]) {
                a1.remove(at: 0)
                a2.remove(at: i)
            } else {
                return false
            }
        }
        return a2.count == 0
    }
    func testEmptyHeap() {
        var heap = Heap<Int>()
        
        XCTAssertTrue(heap.isEmpty)
        XCTAssertEqual(heap.count, 0)
        XCTAssertNil(heap.peek())
        XCTAssertNil(heap.remove())
    }
    
    func testIsEmpty() {
        var heap = Heap<Int>()
        XCTAssertTrue(heap.isEmpty)
        heap.insert(1)
        XCTAssertFalse(heap.isEmpty)
        heap.remove()
        XCTAssertTrue(heap.isEmpty)
    }
    
    func testCount() {
        var heap = Heap<Int>()
        XCTAssertEqual(0, heap.count)
        heap.insert(1)
        XCTAssertEqual(1, heap.count)
    }
    
    func testCreateMinHeap() {
        let h1 = Heap(array: [1, 2, 3, 4, 5, 6, 7] )
        XCTAssertTrue(verifyMinHeap(h1))
        
        XCTAssertEqual(h1.elements, [1, 2, 3, 4, 5, 6, 7])
        XCTAssertFalse(h1.isEmpty)
        XCTAssertEqual(h1.count, 7)
        XCTAssertEqual(h1.peek()!, 1)
        
//        7
//      6   5
//     3 4 2 1
        let h2 = Heap(array: [7, 6, 5, 4, 3, 2, 1] )
        XCTAssertTrue(verifyMinHeap(h2))
        
        XCTAssertEqual(h2.elements, [1, 3, 2, 4, 6, 7, 5])
        XCTAssertFalse(h2.isEmpty)
        XCTAssertEqual(h2.count, 7)
        XCTAssertEqual(h2.peek()!, 1)
        
        let h3 = Heap(array: [4, 1, 3, 2, 16, 9, 10, 14, 8, 7] )
        XCTAssertTrue(verifyMinHeap(h3))
        
        XCTAssertEqual(h3.elements, [1, 2, 3, 4, 7, 9, 10, 14, 8, 16])
        XCTAssertFalse(h3.isEmpty)
        XCTAssertEqual(h3.count, 10)
        XCTAssertEqual(h3.peek()!, 1)
        
        let h4 = Heap(array: [27, 17, 3, 16, 13, 10, 1, 5, 7, 12, 4, 8, 9, 0] )
        XCTAssertTrue(verifyMinHeap(h4))
        
        XCTAssertEqual(h4.elements, [0, 4, 1, 5, 12, 8, 3, 16, 7, 17, 13, 10, 9, 27])
        XCTAssertFalse(h4.isEmpty)
        XCTAssertEqual(h4.count, 14)
        XCTAssertEqual(h4.peek()!, 0)
    }

    func testCreateMinHeapEqualElements() {
        let heap = Heap(array: [1, 1, 1, 1, 1] )
        XCTAssertTrue(verifyMinHeap(heap))
        XCTAssertTrue(verifyMinHeap(heap))
        XCTAssertEqual(heap.elements, [1, 1, 1, 1, 1])
    }
    
    fileprivate func randomArray(_ n: Int) -> [Int] {
        var a = [Int]()
        for _ in 0..<n {
            a.append(Int(arc4random()))
        }
        return a
    }

    func testCreateRandomMinHeap() {
        for n in 1...40 {
            let a = randomArray(n)
            let h = Heap(array: a )
            XCTAssertTrue(verifyMinHeap(h))
            XCTAssertFalse(h.isEmpty)
            XCTAssertEqual(h.count, n)
            XCTAssertTrue(isPermutation(a, h.elements))
        }
    }
    
    
    func testRemoveEmpty() {
        var heap = Heap<Int>()
        let removed = heap.remove()
        XCTAssertNil(removed)
    }

    func testRemoveRoot() {
        var h = Heap(array: [15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1] )
        XCTAssertTrue(verifyMinHeap(h))
        let v = h.remove()
        XCTAssertEqual(v, 0)
        XCTAssertTrue(verifyMinHeap(h))
        
    }
    func testRemoveRandomItems() {

        for n in 1...40 {
            var a = randomArray(n)
            var h = Heap(array: a)
            XCTAssertTrue(verifyMinHeap(h))
            XCTAssertTrue(isPermutation(a, h.elements))

            let m = (n + 1)/2
            for k in 1...m {
                let i = Int(arc4random_uniform(UInt32(n - k + 1)))
                print(h,i)
                let v = h.remove(at:i)!
                let j = a.index(of: v)!
                a.remove(at: j)
                print(h,"----")
                XCTAssert(verifyMinHeap(h), "\(h) is not mineHead")
                XCTAssertTrue(verifyMinHeap(h))
                XCTAssertEqual(h.count, a.count)
                XCTAssertEqual(h.count, n - k)
                XCTAssertTrue(isPermutation(a, h.elements))
            }
        }
    }
    func testRemoveAt(){
        var h = Heap<Int>()
        h.elements = [1,2,3,4,5,16,7,8,9,10,11,17,18,14,15]
        //               1
        //          2          3
        //       4    5     16     7
        //      8 9 10 11  17 18  14 15
        XCTAssertTrue(verifyMinHeap(h))
        print(h)
        h.remove(at:11)
        print(h)
        XCTAssertTrue(verifyMinHeap(h))

    }
    
    func testInsert() {
        var h = Heap(array: [15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1] )

        XCTAssertTrue(verifyMinHeap(h))
        
        
        h.insert(10)
         XCTAssertTrue(verifyMinHeap(h))
        
    }
    
    func testInsertArrayAndRemove() {
        var heap = Heap<Int>()
        heap.insert([1, 3, 2, 7, 5, 9])
        
        print(heap.elements)
        XCTAssertEqual(1, heap.remove())
        print(heap.elements)
        XCTAssertEqual(2, heap.remove())
        print(heap.elements)
        XCTAssertEqual(3, heap.remove())
        print(heap.elements)
        XCTAssertEqual(5, heap.remove())
        print(heap.elements)
        XCTAssertEqual(7, heap.remove())
        print(heap.elements)
        XCTAssertEqual(9, heap.remove())
        print(heap.elements)
        XCTAssertNil(heap.remove())
    }
}
