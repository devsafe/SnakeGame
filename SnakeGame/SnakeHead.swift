//
//  SnakeHead.swift
//  les8
//
//  Created by Boris Sobolev on 30.07.2021.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPOint point: CGPoint) {
        super.init(atPOint: point)
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        
        self.physicsBody?.categoryBitMask = CollisionCategory.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategory.EdgeBody | CollisionCategory.Apple | CollisionCategory.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
