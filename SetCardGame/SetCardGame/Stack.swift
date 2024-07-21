//
//  Stack.swift
//  SetCardGame
//
//  Created by zhira on 7/21/24.
//

import Foundation

struct Stack<Element> {
    private var items: [Element] = []
    
    func peek() -> Element? {   
        return items.first
    }
    
    mutating func pop() -> Element {
        return items.removeFirst()
    }
  
    mutating func push(_ element: Element) {
        items.insert(element, at: 0)
    }
}
