//
//  SetCardGameApp.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

import SwiftUI

@main
struct SetCardGameApp: App {
    @StateObject var game = SetCardGameInterpreter()
    var body: some Scene {
        WindowGroup {
            SetCardGameView(viewModel: game)
        }
    }
}
