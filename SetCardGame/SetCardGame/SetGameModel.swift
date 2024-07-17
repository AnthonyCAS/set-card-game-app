//
//  SetGameModel.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

import Foundation

struct SetGameModel {
    private(set) var cards: [Card]

    struct Card: Identifiable, CustomDebugStringConvertible {
        var chosen: Bool
        let numberOfShapes: Int
        let shape: SetShape
        let shading: SetShading
        let color: String

        let id: String
        var debugDescription: String {
            """
            \(id): \(numberOfShapes) \(shape) \(color) \(shading) \(chosen ? "Chosen" : "")
            """
        }

        var somee: String {
            """
            \(numberOfShapes) \(shape.rawValue) \(shading) \(chosen ? "Chosen" : "")
            """
        }
    }
}

enum SetShape: String {
    case oval = "●"
    case diamond = "♦︎"
    case squiggle = "✖︎"
}

enum SetShading {
    case solid
    case open
    case striped
}
