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
    private let headerHeight: CGFloat = 88
    private let newGameIconSize: CGFloat = 24.0

    var body: some View {
        VStack(spacing: 0) {
            header
            cardsGrid
                .foregroundColor(.blue)
                .animation(.default, value: viewModel.cards)
            footer
        }
        .padding()
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                let sText = Text("S").coloredText(.red)
                let eText = Text("E").coloredText(.green)
                let tText = Text("T").coloredText(.blue)
                Text("\(sText)\(eText)\(tText)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Spacer()
                Text("Cards in deck: \(viewModel.cardsInDeck)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.indigo)
            }
            Spacer()
            VStack {
                Text("Sets found")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.indigo)
                Text("\(viewModel.score)")
                    .font(.system(size: scoreFontSize))
                    .fontWeight(.semibold)
                    .foregroundColor(.indigo)
            }
        }
        .frame(height: headerHeight)
        .padding(spacing)
    }

    private var footer: some View {
        HStack {
            Button(
                action: {
                    viewModel.openNextCards()
                }) {
                    Text("Deal 3 More Cards")
                        .fontWeight(.medium)
                }
                .buttonStyle(
                    GrowingButton(
                        isEnabled: viewModel.canOpenMoreCards,
                        color: .indigo
                    )
                )
                .disabled(!viewModel.canOpenMoreCards)
            Spacer()
            Button(
                action: viewModel.startNewGame
            ) {
                VStack {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: newGameIconSize, height: newGameIconSize)
                    Text("New Game")
                        .fontWeight(.medium)
                }
                .padding(newGameIconSize)
                .foregroundStyle(.indigo)
            }
         
        }
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
