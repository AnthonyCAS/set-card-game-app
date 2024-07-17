//
//  SetFeatures.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

enum SetShape: String, CaseIterable {
    case oval = "●"
    case diamond = "♦︎"
    case squiggle = "✖︎"
}

enum SetShading: CaseIterable {
    case solid
    case open
    case striped
}

enum SetColor: CaseIterable {
    case green
    case red
    case blue
}
