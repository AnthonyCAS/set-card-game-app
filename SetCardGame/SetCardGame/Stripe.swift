//
//  StripeShading.swift
//  SetCardGame
//
//  Created by zhira on 7/18/24.
//

import SwiftUI

struct Stripe: Shape {
    /// the width of each stripe
    let lineWidth: CGFloat
    /// the spacing netween stripe
    let lineSpacing: CGFloat

    /// Initializes a stripe shape with specified line width and spacing.
    /// - Parameters:
    ///   - lineWidth: The width of each stripe, default is 4.
    ///   - lineSpacing: The space between each stripe, default is 4.
    init(lineWidth: CGFloat = 4, lineSpacing: CGFloat = 4) {
        self.lineWidth = lineWidth
        self.lineSpacing = lineSpacing
    }

    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        // if the avaiable space is small is better to use a proportion like width / 7 instead of
        // let fullStripeWidth = lineWidth + lineSpacing
        let fullStripeWidth = width / 7
        var path = Path()
        for x in stride(from: fullStripeWidth, through: width, by: fullStripeWidth) {
            let stripeRect = CGRect(
                x: x,
                y: 0,
                width: lineWidth,
                height: height
            )
            path.addRect(stripeRect)
        }
        return path
    }
}

#Preview {
    Stripe(
        lineWidth: 10,
        lineSpacing: 10
    )
    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    .overlay {
        Circle().stroke(lineWidth: 10)
    }
}
