//
//  Apple.swift
//  les8
//
//  Created by MICHAIL SHAKHVOROSTOV on 29.07.2021.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    init(position: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = UIColor.red
        strokeColor = .red
        lineWidth = 5
        self.position = position
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 8.0, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = COllisionCategary.Apple
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

