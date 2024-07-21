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
    private let headerHeight: CGFloat = 96
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
                Button(action: viewModel.startNewGame) {
                    Label("New Game", systemImage: "plus")
                }
                .buttonStyle(.bordered)
                .tint(.indigo)
            }
            Spacer()
            VStack {
                Text("Sets Found")
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
        HStack(alignment: .top) {
            VStack {
                deck
                    .onTapGesture {
                        viewModel.openNextCards()
                    }
                    .disabled(!viewModel.canOpenMoreCards)
                Text("\(viewModel.cardsInDeck)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.indigo)
            }
            Spacer()
            Button(
                action: viewModel.startNewGame
            ) {
                Label("Shuffle", systemImage: "arrow.clockwise")
            }
            .buttonStyle(GrowingButton(color: .indigo))
            Spacer()
            discardPile
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

    private var discardPile: some View {
        ZStack {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .frame(width: 50, height: 50 / cardAspectRatio)
                    .stacked(at: index, in: viewModel.cards.count)
            }
        }
    }

    private var deck: some View {
        ZStack {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .frame(width: 50, height: 50 / cardAspectRatio)
                    .stacked(at: index, in: viewModel.cards.count)
            }
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: offset * 0.5, y: offset * 0.5)
    }
}

#Preview {
    SetCardGameView(viewModel: SetCardGameInterpreter())
}
