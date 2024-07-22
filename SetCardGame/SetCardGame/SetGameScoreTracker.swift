//
//  SetGameScoreTracker.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

protocol SetGameDelegate: AnyObject {
    func gameDidStart()
    func track(points value: Int)
    func didChooseAWrongSet()
    func didChooseACard()
    func getScore() -> Int
    func getMssg() -> SetGameResponse?
}

class SetGameScoreTracker: SetGameDelegate {
    private var score = 0
    private var mssg: SetGameResponse?

    func gameDidStart() {
        score = 0
    }

    func didChooseACard() {
        mssg = nil
    }
    
    func track(points value: Int) {
        score += value
        mssg = .success
    }
    
    func didChooseAWrongSet() {
        mssg = .fail
    }

    func getScore() -> Int { score }
    
    func getMssg() -> SetGameResponse? { mssg }
}

enum SetGameResponse: String {
    case success = "Set is removed"
    case fail = "It's not a set"
}
