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
        
    }

    func testExample() {
        
    }
}
