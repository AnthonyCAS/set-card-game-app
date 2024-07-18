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
        let color: Color = switch card.color {
        case .red: .red
        case .blue: .blue
        case .green: .green
        }
        return Circle()
            .opacity(0.4)
            .overlay {
                Text("\(card.somee)")
                    .font(.system(size: 25))
                    .minimumScaleFactor(0.02)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(4)
            }
            .padding(Constants.inset)
            .cardify(isSelected: card.isSelected)
            .foregroundColor(color)
    }

    struct Constants {
        static let inset: CGFloat = 4
    }
}

#Preview {
    typealias Card = CardView.Card
    return VStack(spacing: 8) {
        HStack {
            CardView(
                Card(
                    isSelected: true,
                    numberOfShapes: 2,
                    shape: .diamond,
                    shading: .solid,
                    color: .blue,
                    id: "id1"
                )
            )
            CardView(
                Card(
                    numberOfShapes: 1,
                    shape: .diamond,
                    shading: .open,
                    color: .green,
                    id: "id2"
                )
            )
        }
        HStack {
            CardView(
                Card(
                    numberOfShapes: 3,
                    shape: .oval,
                    shading: .striped,
                    color: .blue,
                    id: "id3"
                )
            )
            CardView(
                Card(
                    isSelected: true,
                    numberOfShapes: 2,
                    shape: .squiggle,
                    shading: .open,
                    color: .red,
                    id: "id4"
                )
            )
        }
    }
    .padding()
    .foregroundColor(.green)
}
