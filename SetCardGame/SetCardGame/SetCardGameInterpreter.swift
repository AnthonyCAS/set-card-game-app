//
//  SetCardGameInterpreter.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

import SwiftUI

// This is the ViewModel Entity (I used this name because a conflict on the module name)
class SetCardGameInterpreter: ObservableObject {
    typealias Card = SetGameModel.Card
    
    private static let nextNumberOfCards: Int = 3
    
    @Published private var model = SetGameModel()
    
    var cards: [Card] {
        model.cards.filter { card in
            card.opened
        }
    }
    
    // MARK: - Intents
    
    func openNextCards(_ numberOfCards: Int = nextNumberOfCards) {
        model.openCards(numberOfCards)
    }
}
