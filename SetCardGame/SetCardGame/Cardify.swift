//
//  Cardify.swift
//  SetCardGame
//
//  Created by zhira on 7/16/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    let isSelected: Bool
    
    private var isFaceUp: Bool {
        rotation < 90
    }
    
    private var rotation: Double = 0
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isSelected: Bool, isFaceUp: Bool) {
        self.isSelected = isSelected
        rotation = isFaceUp ? 0 : 180
    }

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base
                .strokeBorder(lineWidth: Constants.lineWidth)
                .background(
                    base
                        .fill(isSelected ? .yellow : Constants.offWhiteColor)
                )
                .overlay(
                    content
                )
                .opacity(isFaceUp ? 1 : 0)
            base
                .fill(.indigo.gradient)
                .overlay {
                    Star()
                        .foregroundColor(.white)
                        .padding(Constants.starShapePadding)
                }
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }

    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let opacity: CGFloat = 0.2
        static let starShapePadding: CGFloat = 4
        static let offWhiteColor: Color = .init(hex: 0xf5f5f5)
    }
}

extension View {
    func cardify(isSelected: Bool, isFaceUp: Bool) -> some View {
        modifier(
            Cardify(
                isSelected: isSelected,
                isFaceUp: isFaceUp
            )
        )
    }
}

extension Color {
    init(hex: Int, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
