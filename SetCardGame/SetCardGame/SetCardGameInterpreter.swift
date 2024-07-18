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
    
    private var gameScoreTracker: SetGameScoreTracker
    @Published private var model: SetGameModel
    
    var cards: [Card] {
        model.cards.filter { card in
            card.isOpened && !card.isASet
        }
    }
    
    var canOpenMoreCards: Bool {
        cardsInDeck > 0 && cards.count < 21
    }
    
    var cardsInDeck: Int {
        model.cards.filter { !$0.isOpened }.count
    }
    
    var score: Int {
           gameScoreTracker.getScore()
       }
    
    init() {
        gameScoreTracker = SetGameScoreTracker()
        model = SetGameModel(with: gameScoreTracker)
    }
    
    // MARK: - Intents
    
    func openNextCards(_ numberOfCards: Int = nextNumberOfCards) {
        if (cards.count < 21) {
            model.openCards(numberOfCards)
        }
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model = SetGameModel()
    }
}
