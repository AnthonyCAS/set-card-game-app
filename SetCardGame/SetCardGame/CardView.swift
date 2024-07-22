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
    var isFaceUp: Bool = true

    init(_ card: Card, isFaceUp: Bool = true) {
        self.card = card
        self.isFaceUp = isFaceUp
    }

    var body: some View {
        let color: Color = switch card.color {
        case .red: .red
        case .blue: .blue
        case .green: .green
        }
        GeometryReader { geometry in
            let width = geometry.size.width
            let padding = Constants.cardPaddingRatio * width
            return VStack(
                spacing: Constants.spacing
            ) {
                let shape = cardShape
                ForEach(0 ..< card.numberOfShapes, id: \.self) { _ in
                    applyShading(to: shape)
                }
            }
            .padding(padding)
            .cardify(
                isSelected: card.isSelected,
                isFaceUp: card.isFaceUp,
                showError: card.showError
            )
            .foregroundColor(color)
            .animation(Constants.rotationAnimation, value: card.isFaceUp)
        }
    }

    private var cardShape: some Shape {
        switch card.shape {
        case .oval:
            AnyShape(Capsule())
        case .squiggle:
            AnyShape(Rectangle())
        case .diamond:
            AnyShape(Diamond())
        }
    }

    @ViewBuilder func applyShading(to shape: some Shape) -> some View {
        switch card.shading {
        case .solid:
            shape
                .aspectRatio(Constants.Shape.aspectRario, contentMode: .fit)
                .clipShape(shape)
        case .open:
            shape
                .stroke(lineWidth: Constants.Shape.lineWidth)
                .aspectRatio(Constants.Shape.aspectRario, contentMode: .fit)
        case .striped:
            shape
                .stroke(lineWidth: Constants.Shape.lineWidth)
                .aspectRatio(Constants.Shape.aspectRario, contentMode: .fit)
                .background(
                    Stripe(lineWidth: Constants.Shape.lineWidth)
                        .clipShape(shape)
                )
        }
    }

    struct Constants {
        static let inset: CGFloat = 4
        static let spacing: CGFloat = 4
        static let cardPaddingRatio: CGFloat = 0.18
        static let rotationAnimation: Animation = .easeInOut(duration: 1)
        struct Shape {
            static let aspectRario: CGFloat = 2 / 1
            static let lineWidth: CGFloat = 2 / 1
        }
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
