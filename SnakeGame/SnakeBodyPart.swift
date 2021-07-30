//
//  SnakeBodyPart.swift
//  les8
//
//  Created by Boris Sobolev on 30.07.2021.
//

import UIKit
import SpriteKit

class SnakeBodyPart:  SKShapeNode {
    let diametr = 10
    
    init(atPOint point: CGPoint) {
        super.init()
        
        path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        fillColor = #colorLiteral(red: 0.9956225753, green: 0.5798057914, blue: 0, alpha: 1)
        strokeColor = #colorLiteral(red: 0.9956225753, green: 0.5798057914, blue: 0, alpha: 1)
        lineWidth = 5
        
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr - 4), center: CGPoint(x: 5, y: 5))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategory.Snake
        
        self.physicsBody?.contactTestBitMask = CollisionCategory.EdgeBody | CollisionCategory.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
