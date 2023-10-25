//
//  PathFinding.swift
//  AStar
//
//  Created by Elvis on 23/10/2023.
//

import Foundation

class PathFinding {
    var grid: Grid
    var open: [Node]
    var close: [Node]
    private (set) var start: Node?
    private (set) var target: Node?
    
    init(gridSizeX: Int, gridSizeY: Int) {
        self.grid = Grid(gridSizeX: gridSizeX, gridSizeY: gridSizeY, pixelSize: 50)
        self.open = []
        self.close = []
    }
    
    func setStart(x: Int, y: Int) {
        if validationPoint(x: x, y: y) == false {
            return
        }
        let index = grid.findNodeIndex(x: x, y: y)
        start = grid.nodes[index]
        start?.type = .Start
    }
    
    func setStart(with index: Int?) {
        guard let index = index else { return }
        if index < 0 || index > grid.nodes.count { return }
        start = grid.nodes[index]
        start?.type = .Start
    }
    
    func setTarget(x: Int, y: Int) {
        if validationPoint(x: x, y: y) == false {
            return
        }
        let index = grid.findNodeIndex(x: x, y: y)
        target = grid.nodes[index]
        target?.type = .End
    }
    
    func setTarget(with index: Int?) {
        guard let index = index else { return }
        if index < 0 || index > grid.nodes.count { return }
        target = grid.nodes[index]
        target?.type = .End
        
    }
    
    func findPath() {
        target?.previousNode = nil
        open = []
        close = []
        if start == nil || target == nil {
            return
        }
        open.append(start!)
        repeat {
            guard let current = getLowsetFInOpen() else { return }
            close.append(current)
            
            if current == target {
                return
            }
            
            let neighbours = grid.getNeighbours(node: current)
            for neighbour in neighbours {
                if neighbour.type == .Wall || close.contains(neighbour) {
                    continue
                }
                if !open.contains(neighbour) {
                    neighbour.setG(previous: current)
                    neighbour.setH(target: target!)
                    neighbour.previousNode = current
                    open.append(neighbour)
                } else {
                    guard let index = open.firstIndex(of: neighbour) else { continue }
                    if neighbour.f < open[index].f {
                        neighbour.setG(previous: current)
                        neighbour.setH(target: target!)
                        neighbour.previousNode = current
                        open[index] = neighbour
                    }
                }
            }
        } while true
    }
    
    func getResult() -> [Node] {
        var list: [Node] = []
        if start == nil || target == nil {
            return list
        }
        if !close.contains(target!) {
            return list
        }
        var head = close.first(where: {$0 == target!})
        if head?.previousNode == nil {
            return list
        }
        while head != nil {
            list.append(head!)
            head = head?.previousNode
        }
        return list
    }
    
    private func getLowsetFInOpen() -> Node? {
        open.sort { $0.f < $1.f }
        if open.isEmpty {
            return nil
        }
        return open.removeFirst()
    }
    
    private func validationPoint(x: Int, y: Int) -> Bool {
        if x >= grid.gridSizeX || y >= grid.gridSizeY {
            return false
        }
        if x < 0 || y < 0 {
            return false
        }
        return true
    }
}
