//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var viewModel: SetCardGameInterpreter

    var body: some View {
        VStack(spacing: 0) {
            cardsGrid
                .foregroundColor(.blue)
            Button(
                action: {
                    viewModel.openNextCards()
                }) {
                    Text("Open 3 Cards")
                        .fontWeight(.medium)
                }
                .buttonStyle(
                    GrowingButton(color: .indigo)
                )
        }
        .padding()
    }

    private var cardsGrid: some View {
        AspectLazyVGrid(viewModel.cards) { card in
            let color: Color = switch card.color {
            case .red: .red
            case .blue: .blue
            case .green: .green
            }
            Circle()
                .opacity(0.4)
                .overlay {
                    Text("\(card.somee)")
                        .font(.system(size: 30))
                        .minimumScaleFactor(0.02)
                        .multilineTextAlignment(.center)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(4)
                }
                .padding(4)
                .cardify(isFaceUp: true)
                .padding(4)
                .foregroundColor(color)
        }
    }
}

#Preview {
    SetCardGameView(viewModel: SetCardGameInterpreter())
}
