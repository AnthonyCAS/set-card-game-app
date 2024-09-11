//
//  SetGameModelTests.swift
//  SetCardGameTests
//
//  Created by Anthony on 9/11/24.
//

import XCTest
@testable import SetCardGame

final class SetGameModelTests: XCTestCase {
    
    var sut: SetGameModel!
    var scoreTracker: SetGameDelegate!
    
    override func setUp() {
        scoreTracker = SetGameScoreTracker()
        sut = SetGameModel(with: scoreTracker)
    }

    override func tearDown() {
        sut = nil
        scoreTracker = nil
    }

    func testCards_WhenGameStart_Return81CardsAnd0Score() {
        // Arrange
        let initialDeckCards = 81
        
        // Act
        
        // Assert
        XCTAssertEqual(sut.cards.count, initialDeckCards, "The initial cards in the game must be 81")
        let score = scoreTracker.getScore()
        XCTAssertEqual(sut.delegate?.getScore(), score, "The score must be Zero")
    }
    
    func testCards_WhenChoose3RandomCards_ReturnsZeroMatchedCards() {
        // Arrange
        let first = sut.cards.randomElement()
        let second = sut.cards.randomElement()
        let third = sut.cards.randomElement()
        
        // Act
        if let first, let second, let third {
            sut.choose(first)
            sut.choose(second)
            sut.choose(third)
            // Assert
            let matchedCards = sut.cards.filter { $0.isMatched }
            XCTAssertEqual(matchedCards.count, 0)
        } else {
            XCTFail("Selecting cards failed")
        }
    }
    
//    func testCards_WhenChoose3RightCards_ReturnsAMatch() {
//        // Arrange
//        let first = sut.cards.randomElement()
//        let second = sut.cards.randomElement()
//        let third = sut.cards.randomElement()
//        
//        // Act
//        if let first, let second, let third {
//            sut.choose(first)
//            sut.choose(second)
//            sut.choose(third)
//            // Assert
//            let matchedCards = sut.cards.filter { $0.isMatched }
//            XCTAssertEqual(matchedCards.count, 0)
//        } else {
//            XCTFail("Selecting cards failed")
//        }
//    }
}
