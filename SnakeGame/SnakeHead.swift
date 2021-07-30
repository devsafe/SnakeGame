//
//  SnakeHead.swift
//  les8
//
//  Created by MICHAIL SHAKHVOROSTOV on 29.07.2021.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPOint point: CGPoint) {
        super.init(atPOint: point)
        
        self.physicsBody?.categoryBitMask = COllisionCategary.SnakeHead
        self.physicsBody?.contactTestBitMask = COllisionCategary.EdgeBody | COllisionCategary.Apple | COllisionCategary.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
