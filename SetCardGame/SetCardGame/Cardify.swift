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
    
    init(isSelected: Bool) {
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
                        .fill(isSelected ? .yellow : .white)
                )
                .overlay(
                    content
                )
                .opacity(isFaceUp ? 1 : 0)
            base
                .fill(.black)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }

    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let opacity: CGFloat = 0.2
    }
}

extension View {
    func cardify(isSelected: Bool) -> some View {
        modifier(Cardify(isSelected: isSelected))
    }
}
