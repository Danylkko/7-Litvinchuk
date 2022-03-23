//
//  MaxPQ.swift
//  
//
//  Created by Danylo Litvinchuk on 14.11.2021.
//

import Foundation

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

struct PriorityQueue<Element: Comparable>: Queue {
    var arr: [Element] = []
    
    mutating func enqueue(_ element: Element) -> Bool {
        if arr.isEmpty {
            arr.append(element)
            return true
        } else {
            for (index, item) in arr.enumerated() {
                if element > item {
                    arr.insert(element, at: index)
                    return true
                } else if index == arr.count - 1 {
                    arr.append(element)
                    return true
                }
            }
        }
        return false
    }
    
    mutating func dequeue() -> Element? {
        return arr.remove(at: 0)
    }
    
    var isEmpty: Bool {
        return arr.count == 0
    }
    
    var peek: Element? {
        return arr.first
    }
    
}

