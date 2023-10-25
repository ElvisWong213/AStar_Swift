//
//  AStarTests.swift
//  AStarTests
//
//  Created by Elvis on 24/10/2023.
//

import XCTest
@testable import AStar

final class AStarTests: XCTestCase {
    var pathFinding: PathFinding?
    
    override func setUpWithError() throws {
        pathFinding = PathFinding(gridSizeX: 4, gridSizeY: 4)
    }

    func testNoWall() {
        guard let pathFinding = pathFinding else { return }
        
        pathFinding.setStart(x: 0, y: 0)
        pathFinding.setTarget(x: 3, y: 3)
        pathFinding.findPath()
        let list = pathFinding.getResult()
        let ans: [Node] = [.init(id: "", x: 3, y: 3), .init(id: "", x: 2, y: 2), .init(id: "", x: 1, y: 1), .init(id: "", x: 0, y: 0)]
        
        XCTAssertEqual(list, ans)
    }
    
    func testWall() {
        guard let pathFinding = pathFinding else { return }
        
        pathFinding.setStart(x: 0, y: 0)
        pathFinding.setTarget(x: 3, y: 3)
        pathFinding.grid.updateNode(Node(id: "", x: 1, y: 1, type: .Wall))
        pathFinding.grid.updateNode(Node(id: "", x: 1, y: 2, type: .Wall))
        pathFinding.findPath()
        let list = pathFinding.getResult()
        let ans: [Node] = [.init(id: "", x: 3, y: 3), .init(id: "", x: 2, y: 2), .init(id: "", x: 2, y: 1), .init(id: "", x: 1, y: 0), .init(id: "", x: 0, y: 0)]
        
        XCTAssertEqual(list, ans)

    }
    
    func testWall2() {
        guard let pathFinding = pathFinding else { return }
        
        pathFinding.setStart(x: 0, y: 0)
        pathFinding.setTarget(x: 3, y: 3)
        pathFinding.grid.updateNode(Node(id: "", x: 1, y: 1, type: .Wall))
        pathFinding.grid.updateNode(Node(id: "", x: 2, y: 1, type: .Wall))
        pathFinding.grid.updateNode(Node(id: "", x: 1, y: 2, type: .Wall))
        pathFinding.grid.updateNode(Node(id: "", x: 1, y: 3, type: .Wall))
        pathFinding.findPath()
        let list = pathFinding.getResult()
        let ans: [Node] = [.init(id: "", x: 3, y: 3), .init(id: "", x: 3, y: 2), .init(id: "", x: 3, y: 1), .init(id: "", x: 2, y: 0), .init(id: "", x: 1, y: 0), .init(id: "", x: 0, y: 0)]
        
        print(list)
        XCTAssertEqual(list, ans)

    }
    
    func testAllBlocked() {
        pathFinding?.setStart(x: 0, y: 0)
        pathFinding?.setTarget(x: 3, y: 3)
        pathFinding?.grid.updateNode(Node(id: "", x: 1, y: 0, type: .Wall))
        pathFinding?.grid.updateNode(Node(id: "", x: 1, y: 1, type: .Wall))
        pathFinding?.grid.updateNode(Node(id: "", x: 1, y: 2, type: .Wall))
        pathFinding?.grid.updateNode(Node(id: "", x: 1, y: 3, type: .Wall))
        pathFinding?.findPath()
        guard let list = pathFinding?.getResult() else { return }

        XCTAssertTrue(list.isEmpty)
    }

}
