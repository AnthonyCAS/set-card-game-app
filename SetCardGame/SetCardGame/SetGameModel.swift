//
//  SetGameModel.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

struct SetGameModel {
    private static let initialNumberOfCards: Int = 12
    private(set) var cards: [Card]
    private var lastOpenCardIndex: Int = 0

    init() {
        lastOpenCardIndex = 0
        cards = []
        cards = product(1 ... 3, SetColor.allCases, SetShape.allCases, SetShading.allCases).map {
            Card(
                numberOfShapes: $0,
                shape: $2,
                shading: $3,
                color: $1,
                id: "\($0)-\($1)-\($2)-\($3)"
            )
        }.shuffled().dropLast(60)
        openCards()
    }

    mutating func openCards(_ numberOfCards: Int = initialNumberOfCards) {
        for index in lastOpenCardIndex ..< lastOpenCardIndex + numberOfCards {
            if cards.indices.contains(index) {
                cards[index].opened = true
                lastOpenCardIndex = index + 1
            } else {
                // no more cards
                break
            }
        }
    }

    struct Card: Identifiable, CustomDebugStringConvertible {
        var selected: Bool = false
        var opened: Bool = false
        let numberOfShapes: Int
        let shape: SetShape
        let shading: SetShading
        let color: SetColor

        let id: String
        var debugDescription: String {
            """
            \(id): \(numberOfShapes) \(shape) \(color) \(shading) \(selected ? "Chosen" : "")
            """
        }

        var somee: String {
            """
            \(numberOfShapes) \(shape.rawValue) \(shading) \(selected ? "Chosen" : "")
            """
        }
    }
}
