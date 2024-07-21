//
//  SetGameModel.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

struct SetGameModel {
    private static let initialNumberOfCards: Int = 12

    private(set) var cards: [Card]

    weak var delegate: SetGameDelegate?

    private var indexOfSelectedCards: [Int] {
        cards.indices.filter { cards[$0].isSelected }
    }

    init(
        with gameTracker: SetGameDelegate? = nil
    ) {
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
        delegate = gameTracker
        delegate?.gameDidStart()
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isSelected {
                if indexOfSelectedCards.count < 3 {
                    delegate?.didChooseACard()
                    cards[chosenIndex].isSelected.toggle()
                    if let potentialSetIndices = indexOfSelectedCards.onlyThree {
                        // there are exactly 3 potential selected cards in the game
                        let card1 = cards[potentialSetIndices[0]]
                        let card2 = cards[potentialSetIndices[1]]
                        let card3 = cards[potentialSetIndices[2]]
                        if cardsBelongToASet(card1, card2, card3) {
                            // a set found!
                            deselectCards(potentialSetIndices)
                            for index in potentialSetIndices {
                                cards[index].isFaceUp = false
                                cards[index].isMatched = true
                            }
                            delegate?.track(points: 1)
                            // draw 3 more cards if there are less than 12 cards
//                            if (cards.filter {
//                                $0.isDealt && !$0.isMatched
//                            }.count < 12) {
//                                dealCards(3)
//                            }
                        } else {
                            // the three selected cards don't conform to be a Set
                            deselectCards(potentialSetIndices)
                            delegate?.didChooseAWrongSet()
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
        return true
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
    
    mutating func shuffle() {
        cards.shuffle()
    }

    struct Card: Identifiable, CustomDebugStringConvertible, Hashable {
        var isFaceUp: Bool = true
        var isSelected: Bool = false
        // if a card already belong to a set
        var isMatched: Bool = false {
            didSet {
                if isMatched {
                    isFaceUp = false
                }
            }
        }
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
    }
}

extension Array {
    // return the first 3 elements in the list only if there are exactly 3 elements
    var onlyThree: [Element]? {
        count == 3 ? Array(self[0 ..< 3]) : nil
    }
}
