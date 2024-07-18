//
//  Cardify.swift
//  SetCardGame
//
//  Created by zhira on 7/16/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isSelected: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base
                .strokeBorder(lineWidth: Constants.lineWidth)
                .background(
                    base
                        .fill(isSelected ? .yellow : .white)
                        .opacity(Constants.opacity)
                )
                .overlay(content)                
        }
    }
    
    struct Constants {
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
