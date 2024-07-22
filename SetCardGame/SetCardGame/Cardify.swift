//
//  Cardify.swift
//  SetCardGame
//
//  Created by zhira on 7/16/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    let isSelected: Bool
    let showError: Bool

    private var isFaceUp: Bool {
        rotation < 90
    }

    private var rotation: Double = 0

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    @State private var progress: Double = 0.0

    init(isSelected: Bool, isFaceUp: Bool, showError: Bool) {
        self.isSelected = isSelected
        self.showError = showError
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
            if showError {
                base
                    .trim(from: .zero, to: progress)
                    .glow(
                        fill: .palette,
                        lineWidth: Constants.glowLineWidth
                    )
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 1.5)
                        ) {
                            progress = 1
                        } completion: {
                            progress = 0
                        }
                    }
            }

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
        static let glowLineWidth: CGFloat = 4
        static let offWhiteColor: Color = .init(hex: 0xf5f5f5)
    }
}

extension View {
    func cardify(isSelected: Bool, isFaceUp: Bool, showError: Bool) -> some View {
        modifier(
            Cardify(
                isSelected: isSelected,
                isFaceUp: isFaceUp,
                showError: showError
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

extension View where Self: Shape {
    func glow(
        fill: some ShapeStyle,
        lineWidth: Double,
        blurRadius: Double = 8.0,
        lineCap: CGLineCap = .round
    ) -> some View {
        stroke(
            style: StrokeStyle(
                lineWidth: lineWidth / 2,
                lineCap: lineCap
            )
        )
        .fill(fill)
        .overlay {
            self
                .stroke(
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: lineCap
                    )
                )
                .fill(fill)
                .blur(radius: blurRadius)
            }
    }
}

extension ShapeStyle where Self == AngularGradient {
    static var palette: some ShapeStyle {
        .angularGradient(
            stops: [
                .init(color: .red, location: 0.0),
                .init(color: .blue, location: 0.2),
                .init(color: .red, location: 0.4),
                .init(color: .green, location: 0.6),
                .init(color: .red, location: 0.8),                
                .init(color: .blue, location: 1.0),
            ],
            center: .center,
            startAngle: Angle(radians: .zero),
            endAngle: Angle(radians: .pi * 2)
        )
    }
}
