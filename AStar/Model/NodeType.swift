//
//  NodeType.swift
//  AStar
//
//  Created by Elvis on 23/10/2023.
//

import Foundation
import AppKit

enum NodeType: CustomStringConvertible {
    case Wall, Air, Start, End, Path
    
    var color: NSColor {
        switch self {
        case .Wall:
            return .gray
        case .Air:
            return .black
        case .Start:
            return .green
        case .End:
            return .red
        case .Path:
            return .blue
        }
    }
    
    var description: String {
        switch self {
        case .Wall:
            return "Wall"
        case .Air:
            return "Air"
        case .Start:
            return "Start"
        case .End:
            return "End"
        case .Path:
            return "Path"
        }
    }
}
