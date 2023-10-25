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
    
    private (set) var g: Int
    private (set) var h: Int
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

    func reset() {
        self.g = 0
        self.h = 0
        self.type = .Air
        self.previousNode = nil
    }
    
    func setG(previous: Node) {
        self.g = previous.g + distance(nodeA: previous, nodeB: self)
//        print("g: \(self.g) \(self.description)")
    }
    
    func setH(target: Node) {
        h = distance(nodeA: self, nodeB: target)
    }
    
    func distance(nodeA: Node, nodeB: Node) -> Int {
        let d = 10
        let d2 = 14
        let xDiff = abs(nodeA.x - nodeB.x)
        let yDiff = abs(nodeA.y - nodeB.y)
        
        return d * (xDiff + yDiff) + (d2 - 2 * d) * min(xDiff, yDiff)
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
