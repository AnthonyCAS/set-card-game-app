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
        
    private var gameScoreTracker: SetGameScoreTracker
    @Published private var model: SetGameModel
    
    var cards: [Card] {
        model.cards
    }
    
    var score: Int {
        gameScoreTracker.getScore()
    }
    
    init() {
        gameScoreTracker = SetGameScoreTracker()
        model = SetGameModel(with: gameScoreTracker)
    }
    
    // MARK: - Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func startNewGame() {
        model = SetGameModel(with: gameScoreTracker)
    }
    
    func deselectCards() {
        model.deselectCards()
    }
    
    func dealCard(_ card: Card) {
        model.dealCard(card)
    }
}
