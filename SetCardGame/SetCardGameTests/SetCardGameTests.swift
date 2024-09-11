//
//  SetCardGameInterpreterTests.swift
//  SetCardGameInterpreterTests
//
//  Created by Anthony on 9/11/24.
//

import XCTest
@testable import SetCardGame

final class SetCardGameInterpreterTests: XCTestCase {
    
    var sut: SetCardGameInterpreter!
    var scoreTracker: SetGameScoreTracker!

    override func setUp() {
        scoreTracker = SetGameScoreTracker()
        sut = SetCardGameInterpreter(scoreTracker: scoreTracker)
        // setup draw of initial 12 cards
        let initialDealtCards = 12
        
        // Act
        for card in sut.cards.prefix(initialDealtCards) {
            sut.dealCard(card)
        }
    }

    override func tearDown() {
        sut = nil
        scoreTracker = nil
    }
    
    func testDeckCards_WhenGameStart_Return81Cards() {
        // Arrange
        let initialDeckCards = 81
        
        // Act
        
        // Assert
        XCTAssertEqual(sut.cards.count, initialDeckCards, "The initial cards in the game must be 81")
    }

    func testInitialDealtCards_WhenGameStart_Return12Cards() {
        // Arrange
        let initialDealtCards = 12
        // Act
        let dealtCards = sut.cards.filter { $0.isFaceUp }
        let selectedCards = sut.cards.filter { $0.isSelected }
        // Assert
        XCTAssertEqual(dealtCards.count, initialDealtCards, "Dealt cards in the table are 12 when game starts")
        XCTAssertEqual(selectedCards.count, 0, "There shouldn't be any card selected")
    }
    
    func testDealtCards_WhenSelect1Cards_HasOnlyOneSelectedCard() {
        // Arrange
        let initialCardsCount = 12
        let initialCards = sut.cards.filter { $0.isFaceUp }
        
        // Act
        // Assert
        XCTAssertEqual(initialCards.count, initialCardsCount)
        
        if let firstCard = initialCards.first  {
            sut.choose(firstCard)
            let selectedCards = sut.cards.filter { $0.isSelected }
            // Assert
            XCTAssertEqual(selectedCards.count, 1, "No selected card found")
        } else {
            XCTFail("No selected card found")
        }
    }
    
    func testDealtCards_WhenShuffleCards_returnDifferentDealtCards() {
        // Arrange
        let dealtCards = sut.cards.filter { $0.isFaceUp }
                
        if let firstCard = dealtCards.first  {
            // Act
            sut.shuffle()
            let shuffledDealtCards = sut.cards.filter { $0.isFaceUp }
            // Assert
            XCTAssertNotNil(shuffledDealtCards.first, "No dealt cards found in the deck")
            XCTAssertNotEqual(firstCard.id, shuffledDealtCards.first!.id, "the first card in the table is the same after the shuffle")
        } else {
            XCTFail("Shuffle cards should return a different card almost always, but in some case the first card in the table could be the same")
        }
    }
    
    func testDealtCards_WhenDeselectCards_ClearsSelectedCards() {
        // Arrange
        let dealtCards = sut.cards.filter { $0.isFaceUp }
                
        // Act
        if let firstCard = dealtCards.first  {
            sut.choose(firstCard)
            var selectedCards = sut.cards.filter { $0.isSelected }
            // Assert
            XCTAssertEqual(selectedCards.count, 1, "No selected card found")
            // Act
            sut.deselectCards()
            selectedCards = sut.cards.filter { $0.isSelected }
            // Assert
            XCTAssertEqual(selectedCards.count, 0, "There shouldn'be any selected card")
        } else {
            XCTFail("No selected card found")
        }
    }
    
    func testScoreTracker_WhenStartNewgame_ShouldResetTheScore() {
        // Arrange
        let newScore: Int = 1
        // Act
        scoreTracker.track(points: newScore)
        
        // Assert
        XCTAssertEqual(scoreTracker.getScore(), newScore, "Game Score must be \(newScore)")
        
        // Act
        sut.startNewGame()
        // Assert
        XCTAssertEqual(scoreTracker.getScore(), 0, "Game Score must be 0")
    }
}
