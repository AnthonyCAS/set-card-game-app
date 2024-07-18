//
//  SetGameModel.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

struct SetGameModel {
    private static let initialNumberOfCards: Int = 12

    private(set) var cards: [Card]
    private var lastOpenCardIndex: Int
    
    weak var delegate: SetGameDelegate?

    private var indexOfSelectedCards: [Int] {
        cards.indices.filter { cards[$0].isSelected }
    }

    init(
        with gameTracker: SetGameDelegate? = nil
    ) {
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
        }.shuffled()
        openCards()
        delegate = gameTracker
        delegate?.gameDidStart()
    }

    mutating func openCards(_ numberOfCards: Int = initialNumberOfCards) {
        for index in lastOpenCardIndex ..< lastOpenCardIndex + numberOfCards {
            if cards.indices.contains(index) {
                cards[index].isOpened = true
                lastOpenCardIndex = index + 1
            } else {
                // no more cards
                break
            }
        }
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isSelected, cards[chosenIndex].isOpened {
                if indexOfSelectedCards.count < 3 {
                    cards[chosenIndex].isSelected.toggle()
                    if let potentialSetIndices = indexOfSelectedCards.onlyThree {
                        // there are exactly 3 potential selected cards in the game
                        let card1 = cards[potentialSetIndices[0]]
                        let card2 = cards[potentialSetIndices[1]]
                        let card3 = cards[potentialSetIndices[2]]
                        if cardsBelongToASet(card1, card2, card3) {
                            // a set found
                            deselectCards(potentialSetIndices)
                            for index in potentialSetIndices {
                                cards[index].isASet = true
                            }
                            delegate?.track(points: 1)
                            // draw 3 more cards if there are less than 12 cards
                            if (cards.filter{
                                $0.isOpened && !$0.isASet
                            }.count < 12) {
                                openCards(3)
                            }
                        } else {
                            // the three selected cards don't conform to be a Set
                            deselectCards(potentialSetIndices)
                        }
                    }
                }
            } else {
                cards[chosenIndex].isSelected = false
            }
        }
    }
    
    private mutating func deselectCards(_ indices: [Int]) {
        for index in indices {
            cards[index].isSelected = false
        }
    }

    private func cardsBelongToASet(_ cards: Card...) -> Bool {
        let numberOfShapesSet = Set(cards.map { $0.numberOfShapes })
        let colorSet = Set(cards.map { $0.color })
        let shapeSet = Set(cards.map { $0.shape })
        let shadingSet = Set(cards.map { $0.shading })
        return
            (numberOfShapesSet.count == 1 ||
            numberOfShapesSet.count == 3)
            && (colorSet.count == 1 ||
            colorSet.count == 3)
            && (shapeSet.count == 1 ||
            shapeSet.count == 3)
            && (shadingSet.count == 1 ||
            shadingSet.count == 3)
    }

    struct Card: Identifiable, CustomDebugStringConvertible, Hashable {
        var isSelected: Bool = false
        // this property is used to display the card in the UI
        var isOpened: Bool = false
        // if a card already belong to a set
        var isASet: Bool = false
        let numberOfShapes: Int
        let shape: SetShape
        let shading: SetShading
        let color: SetColor

        let id: String
        var debugDescription: String {
            """
            \(id): \(numberOfShapes) \(shape) \(color) \(shading) \(isSelected ? "Chosen" : "")
            """
        }

        var somee: String {
            """
            \(numberOfShapes) \(shape.rawValue) \(shading)
            """
        }
    }
}

extension Array {
    // return the first 3 elements in the list only if there are exactly 3 elements
    var onlyThree: [Element]? {
        count == 3 ? Array(self[0 ..< 3]) : nil
    }
}
