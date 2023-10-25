//
//  GameScene.swift
//  AStar
//
//  Created by Elvis on 22/10/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let pathFinding = PathFinding(gridSizeX: 20, gridSizeY: 20)
    var type: NodeType = .Wall
    var selectedText: SKLabelNode?
    let pixelSize = 20
    var pathFindingNodes: [SKNode] = []

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        for node in pathFinding.grid.nodes {
            let n = SKSpriteNode(color: node.type.color, size: .init(width: pixelSize, height: pixelSize))
            let xSpace = Double(pixelSize) * Double(node.x) + Double(5) * Double(node.x + 10)
            let ySpace = Double(pixelSize) * Double(node.y) + Double(5) * Double(node.y + 10)
            n.position = .init(x: xSpace, y: ySpace)
            n.name = node.id
            pathFindingNodes.append(n)
            self.addChild(n)
        }
        
        self.selectedText = self.childNode(withName: "selectedText") as? SKLabelNode
        if let selectedText = self.selectedText {
            selectedText.color = type.color
            selectedText.fontName = "AvenirNext-Bold"
            selectedText.text = type.description
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        guard let node = nodes(at: pos).first as? SKSpriteNode else { return }
        changeNode(node: node)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        guard let node = nodes(at: pos).first as? SKSpriteNode else { return }
        changeNode(node: node)
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        handleKeyEvent(event, keyDown: true)
    }
    
//    override func keyUp(with event: NSEvent) {
//        handleKeyEvent(event, keyDown: false)
//    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene {
    func changeNode(node: SKSpriteNode) {
        guard let index = node.name else { return }
        switch type {
        case .Wall, .Air:
            node.color = type.color
            pathFinding.grid.updateNode(with: Int(index), type: type)
        case .Start:
            for node in pathFinding.getResult() {
                path(node: node, type: .Air)
            }
            node.color = type.color
            if let nodeName = pathFinding.start?.id {
                if index != pathFinding.start?.id {
                    let n = self.childNode(withName: nodeName) as? SKSpriteNode
                    n?.color = NodeType.Air.color
                }
            }
            pathFinding.setStart(with: Int(index))
        case .End:
            for node in pathFinding.getResult() {
                path(node: node, type: .Air)
            }
            node.color = type.color
            if let nodeName = pathFinding.target?.id {
                if index != pathFinding.target?.id {
                    let n = self.childNode(withName: nodeName) as? SKSpriteNode
                    n?.color = NodeType.Air.color
                }
            }
            pathFinding.setTarget(with: Int(index))
        case .Path:
            break
        }
        
    }
    
    func handleKeyEvent(_ event: NSEvent, keyDown: Bool) {
        if let characters = event.characters {
            for character in characters {
                switch character {
                case "w":
                    type = .Wall
                case "s":
                    type = .Start
                case "e":
                    type = .End
                case "a":
                    type = .Air
                case "p":
                    pathFinding.findPath()
                    let nodes = pathFinding.getResult()
                    for node in nodes {
                        path(node: node)
                    }
                case "r":
                    restart()
                default:
                    type = .Air
                }
                updateSelectedText()
            }
        }
    }
    
    func path(node: Node, type: NodeType = .Path) {
        let nodeName = node.id
        if nodeName != pathFinding.start?.id && nodeName != pathFinding.target?.id {
            let n = self.childNode(withName: nodeName) as? SKSpriteNode
            n?.color = type.color
        }
    }
    
    func updateSelectedText() {
        self.selectedText?.text = type.description
        self.selectedText?.color = type.color
    }
    
    func restart() {
        pathFinding.grid.resetAllNodes()
        self.removeChildren(in: pathFindingNodes)
        for node in pathFinding.grid.nodes {
            let n = SKSpriteNode(color: node.type.color, size: .init(width: pixelSize, height: pixelSize))
            let xSpace = Double(pixelSize) * Double(node.x) + Double(5) * Double(node.x + 10)
            let ySpace = Double(pixelSize) * Double(node.y) + Double(5) * Double(node.y + 10)
            n.position = .init(x: xSpace, y: ySpace)
            n.name = node.id
            self.addChild(n)
        }
    }
}
