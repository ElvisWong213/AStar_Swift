//
//  Node.swift
//  AStar
//
//  Created by Elvis on 23/10/2023.
//

import Foundation

class Node: Identifiable {
    let id: String
    let x: Int
    let y: Int
    
    var g: Int
    var h: Int
    var f: Int {
        get {
            return g + h
        }
    }
    var type: NodeType
    
    var previousNode: Node?
    
    init(id: String, x: Int, y: Int, g: Int = 0, h: Int = 0, type: NodeType = .Air, previousNode: Node? = nil) {
        self.id = id
        self.x = x
        self.y = y
        self.g = g
        self.h = h
        self.type = type
        self.previousNode = previousNode
    }
}

extension Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension Node: CustomStringConvertible {    
    public var description: String {
        return "(x: \(self.x), y: \(self.y))"
    }
}
