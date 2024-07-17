//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

import SwiftUI

struct SetCardGameView: View {
    let cards = [
        SetGameModel.Card(
            chosen: false, numberOfShapes: 2, shape: .diamond, shading: .striped, color: "red", id: "1"
        ),
        SetGameModel.Card(
            chosen: false, numberOfShapes: 3, shape: .squiggle, shading: .open, color: "blue", id: "2"
        ),
        SetGameModel.Card(
            chosen: false, numberOfShapes: 1, shape: .oval, shading: .solid, color: "green", id: "3"
        ),
        SetGameModel.Card(
            chosen: false, numberOfShapes: 2, shape: .diamond, shading: .open, color: "red", id: "4"
        )
    ]
    var body: some View {
        VStack(spacing: 0) {
            cardsGrid
                .foregroundColor(.blue)                
        }
        .padding()
    }

    private var cardsGrid: some View {
        AspectLazyVGrid(cards) { card in
            let color: Color = switch card.color {
            case "red": .red
            case "blue": .blue
            case "green": .green
            default: .red
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
    SetCardGameView()
}
