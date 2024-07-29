//
//  Star.swift
//  SetCardGame
//
//  Created by zhira on 7/21/24.
//

import SwiftUI

/// Star shape used in the back of card
struct Star: Shape {
    
    func path(in rect: CGRect) -> Path {
        let (x, y, width, height) = rect.centeredSquare.flatten()
        let radius = width / 2
        let lowerPoint = CGPoint(
            x: x + radius,
            y: y + height
        )
        
        let path = Path { p in
            p.move(to: lowerPoint)
            p.addArc(
                center: CGPoint(x: x, y: (y + height)),
                radius: radius,
                startAngle: .A360,
                endAngle: .A270,
                clockwise: true
            )
            p.addArc(
                center: CGPoint(x: x, y: y),
                radius: radius,
                startAngle: .A90,
                endAngle: .zero,
                clockwise: true
            )
            
            p.addArc(
                center: CGPoint(x: x + width, y: y),
                radius: radius,
                startAngle: .A180,
                endAngle: .A90,
                clockwise: true)

            p.addArc(
                center: CGPoint(x: x + width, y: y + height),
                radius: radius,
                startAngle: .A270,
                endAngle: .A180,
                clockwise: true
            )
        }
        return path
    }
    
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: self.midX, y: self.midY)
    }
    
    var centeredSquare: CGRect {
        let width = ceil(min(size.width, size.height))
        let height = width
        
        let newOrigin = CGPoint(x: origin.x + (size.width - width) / 2, y: origin.y + (size.height - height) / 2)
        let newSize = CGSize(width: width, height: height)
        return CGRect(origin: newOrigin, size: newSize)
    }
    
    func flatten() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        return (origin.x, origin.y, size.width, size.height)
    }
}

extension Angle {
    static let A180 = Angle(radians: .pi)
    static let A90 = Angle(radians: .pi / 2)
    static let A270 = Angle(radians: (.pi / 2) * 3)
    static let A360 = Angle(radians: .pi * 2)
}
