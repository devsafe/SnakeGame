//
//  Apple.swift
//  les8
//
//  Created by Boris Sobolev on 30.07.2021.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    init(position: CGPoint) {
        super.init()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        lineWidth = 5
        self.position = position
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 8.0, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = CollisionCategory.Apple
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

