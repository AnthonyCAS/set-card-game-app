//
//  CardView.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

import SwiftUI

struct CardView: View {
    typealias Card = SetGameModel.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        Circle()
            .opacity(0.4)
            .padding()
            .cardify(isFaceUp: true)
    }
}
