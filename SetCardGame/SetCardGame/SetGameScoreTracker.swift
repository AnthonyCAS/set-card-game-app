//
//  SetGameScoreTracker.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

protocol SetGameDelegate: AnyObject {
    func gameDidStart()
    func track(points value: Int)
    func getScore() -> Int
}

class SetGameScoreTracker: SetGameDelegate {
    private var score = 0

    func gameDidStart() {
        score = 0
    }

    func track(points value: Int) {
        score += value
    }

    func getScore() -> Int { score }
}
