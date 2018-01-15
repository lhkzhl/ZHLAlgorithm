//
//  Trie.swift
//  ZHLAlgorithm
//
//  Created by hailong on 2017/10/31.
//  Copyright © 2017年 hailong. All rights reserved.
//

import UIKit

class Trie {
    class TrieNode<T:Hashable> {
        var value:T?
        var children:[T:TrieNode] = [:]
        weak var parentNode:TrieNode?
        
        /// 单词的结尾
        var isTerminating = false

        init(value:T? = nil,parentNode:TrieNode? = nil) {
            self.value = value
            self.parentNode = parentNode
        }
        
        /// 叶子结点
        var isLeaf:Bool{
            return children.count == 0
        }
        func add(value:T){
//
            guard children[value] == nil else{
                return
            }
            
            children[value] = TrieNode(value: value, parentNode: self)
        }
    
    }
    
    typealias Node = TrieNode<Character>
    
    
    fileprivate let root:Node
    fileprivate var wordCount:Int
//    var words:[String]
    
    
    //    MARK:get
    var isEmpty:Bool{
        return wordCount == 0
    }
    var count:Int{
        return wordCount
    }
    var words:[String]{
        return wordsInSubtrie(rootNode: root, partialWord: "")
    }

    init() {
        root = Node()
        wordCount = 0
    }
}
extension Trie{
    func insert(word:String){
        guard !word.isEmpty else {
            return
        }
        var curr = root
        for c in word.lowercased(){
            if let childNode =  curr.children[c]{
                curr = childNode
            }else{
                curr.add(value: c)
                curr = curr.children[c]!
            }
        }
        
        if !curr.isTerminating{
            wordCount += 1
            curr.isTerminating = true
        }
        
//        guard !curr.isTerminating else {
//            return
//        }
//        wordCount += 1
//        curr.isTerminating = true
    }
    
    func contains(word:String)->Bool{
        guard !word.isEmpty else {
            return false
        }
        
        var curr = root
        for c in word.lowercased(){
            if let childNode = curr.children[c]{
                curr = childNode
            }else{
                return false
            }
        }
        return curr.isTerminating
    }
    
    private func findLastNodeOf(word:String)->Node?{
        var curr = root
        for c in word.lowercased(){
            if let childNode = curr.children[c]{
                curr = childNode
            }else{
                return nil
            }
        }
        return curr
    }
    
    func findTerminalNodeOf(word:String)->Node?{
        if let node = findLastNodeOf(word: word){
            return node.isTerminating ? node: nil
        }
        return nil
    }
    
    
    /// 从下往上删除 node.isLeaf = ture && node.terminalNode = false
    ///
    /// - Parameter terminalNode: <#terminalNode description#>
    func deleteNodesForWordEndingWith(terminalNode:Node){
//        terminalNode.isTerminating 是 true
        var lastNode = terminalNode
        var char = lastNode.value
        while lastNode.isLeaf,
            let parentNode = lastNode.parentNode{
                lastNode = parentNode
                lastNode.children[char!] = nil
                char = lastNode.value
                if lastNode.isTerminating{
                    return
                }
        }
        
    }
    
    func remove(word:String){
        if word.isEmpty {
            return
        }
        
        guard let terminalNode = findTerminalNodeOf(word: word) else{
            return
        }
        
        if terminalNode.isLeaf{
            deleteNodesForWordEndingWith(terminalNode: terminalNode)
        }else{
            terminalNode.isTerminating = false
        }
        wordCount -= 1
    }
    
    /// 自上而下，先拼接char,当rootNode.isTerminating 拼接word
    ///
    fileprivate func wordsInSubtrie(rootNode:Node,partialWord: String)->[String]{
        var words = [String]()
        var previousLetters = partialWord
        if let value = rootNode.value{
            previousLetters.append(value)
        }
        if rootNode.isTerminating{
            words.append(previousLetters)
        }
        for child in rootNode.children.values{
            let childWords = wordsInSubtrie(rootNode: child, partialWord: previousLetters)
            words += childWords
        }
        return words
    }
    
    
    func findWordsWithPrefix(prefix:String) -> [String]{
        var words = [String]()
        let prefixLowerCased = prefix.lowercased()
        if let lastNode = findLastNodeOf(word: prefixLowerCased){
            if lastNode.isTerminating{
                words.append(prefixLowerCased)
            }
            for child in lastNode.children.values{
                let childWords = wordsInSubtrie(rootNode: child, partialWord: prefixLowerCased)
                words += childWords
            }
        }
        return words
    }
    
}
















