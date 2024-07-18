//
//  Diamond.swift
//  SetCardGame
//
//  Created by zhira on 7/18/24.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        let midx = rect.midX
        let midy = rect.midY
        var path = Path()
        path.move(to: CGPoint(x: 0, y: midy))
        path.addLine(to: CGPoint(x: midx, y: 0))
        path.addLine(to: CGPoint(x: width, y: midy))
        path.addLine(to: CGPoint(x: midx, y: height))
        path.addLine(to: CGPoint(x: 0, y: midy))
        path.closeSubpath()
        return path
    }
}

#Preview {
    Diamond()
        .stroke(lineWidth: 10)
        .frame(width: 150, height: 100)
}
