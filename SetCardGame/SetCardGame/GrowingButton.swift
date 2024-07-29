//
//  GrowingButton.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    let isEnabled: Bool = true
    let color: Color
    let disabledColor: Color = .gray

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isEnabled ? color : disabledColor)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? Constants.scaleWhenPressed : 1)
            .animation(.easeOut(duration: Constants.animationDuration), value: configuration.isPressed)
    }
    
    private struct Constants {
        static let scaleWhenPressed: CGFloat = 1.2
        static let animationDuration: CGFloat = 0.5
    }
}

extension Text {
    func coloredText(_ color: Color) -> Text {
        foregroundColor(color)
    }
}
