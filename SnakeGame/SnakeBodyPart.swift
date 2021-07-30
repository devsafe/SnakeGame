//
//  SnakeBodyPart.swift
//  les8
//
//  Created by MICHAIL SHAKHVOROSTOV on 29.07.2021.
//

import UIKit
import SpriteKit

class SnakeBodyPart:  SKShapeNode {
    let diametr = 10
    
    init(atPOint point: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        fillColor = .green
        strokeColor = .green
        lineWidth = 5
        
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr - 4), center: CGPoint(x: 5, y: 5))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = COllisionCategary.Snake
        
        self.physicsBody?.contactTestBitMask = COllisionCategary.EdgeBody | COllisionCategary.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
