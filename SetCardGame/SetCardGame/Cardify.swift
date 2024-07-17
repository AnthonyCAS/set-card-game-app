//
//  Cardify.swift
//  SetCardGame
//
//  Created by zhira on 7/16/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base
                .strokeBorder(lineWidth: Constants.lineWidth)
                .background(
                    base
                        .fill(.white)
                )
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base
                .fill()
                .opacity(isFaceUp ? 0 : 1)
        }
    }
    
    struct Constants {
        static var cornerRadius: CGFloat = 12
        static var lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
