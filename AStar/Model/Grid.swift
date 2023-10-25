//
//  Grid.swift
//  AStar
//
//  Created by Elvis on 23/10/2023.
//

import Foundation

class Grid {
    private (set) var gridSizeX: Int
    private (set) var gridSizeY: Int
    var nodes: [Node]
    
    init(gridSizeX: Int, gridSizeY: Int, pixelSize: Int) {
        self.gridSizeX = gridSizeX
        self.gridSizeY = gridSizeY
        self.nodes = []
        self.resetAllNodes()
    }
    
    func resetAllNodes() {
        self.nodes = []
        for x in 0..<gridSizeX {
            for y in 0..<gridSizeY {
                let id = String(findNodeIndex(x: x, y: y))
                let node = Node(id: id, x: x, y: y)
                nodes.append(node)
            }
        }
        
    }
    
    func findNodeIndex(x: Int, y: Int) -> Int {
        return x * gridSizeY + y
    }
    
    func updateNode(_ node: Node) {
        let index = findNodeIndex(x: node.x, y: node.y)
        nodes[index] = node
    }
    
    func updateNode(with index: Int?, type: NodeType) {
        guard let index = index else { return }
        nodes[index].type = type
    }
    
    func resetNode(node: Node) {
        let index = findNodeIndex(x: node.x, y: node.y)
        nodes[index].reset()
    }
    
    func getNeighbours(node: Node) -> [Node] {
        var list: [Node] = []
        for x in node.x - 1 ... node.x + 1 {
            for y in node.y - 1 ... node.y + 1 {
                if x == node.x && y == node.y {
                    continue
                }
                if x >= 0 && x < gridSizeX && y >= 0 && y < gridSizeY {
                    let index = findNodeIndex(x: x, y: y)
                    list.append(nodes[index])
                }
            }
        }
        return list
    }
}
