//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var viewModel: SetCardGameInterpreter
    private let cardAspectRatio: CGFloat = 2 / 3
    private let spacing: CGFloat = 4
    private let scoreFontSize: CGFloat = 64

    var body: some View {
        VStack(spacing: 0) {
            cardsGrid
                .foregroundColor(.blue)
                .animation(.default, value: viewModel.cards)
            Button(
                action: {
                    viewModel.openNextCards()
                }) {
                    Text("Open 3 Cards")
                        .fontWeight(.medium)
                }
                .buttonStyle(GrowingButton(color: .indigo))
        }
        .padding()
    }

    private var cardsGrid: some View {
        AspectLazyVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

#Preview {
    SetCardGameView(viewModel: SetCardGameInterpreter())
}
