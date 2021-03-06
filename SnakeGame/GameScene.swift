//
//  GameScene.swift
//  les8
//
//  Created by Boris Sobolev on 30.07.2021.
//

import SpriteKit
import GameplayKit
import UIKit

struct CollisionCategory {
    static let Snake: UInt32 = 0x1 << 0 //0001 1
    static let SnakeHead: UInt32 = 0x1 << 1 //0010 2
    static let Apple: UInt32 = 0x1 << 2 //0100 4
    static let EdgeBody: UInt32 = 0x1 << 3 //1000 8
}

class GameScene: SKScene {
    
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.allowsRotation = false
        
        view.showsPhysics = false
        
        
        let counterClockButton = SKShapeNode()
        counterClockButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY+30)
        let imageLeft = UIImage(systemName: "arrow.counterclockwise")
        let imageLeftColor = UIImageView(image: imageLeft)
        imageLeftColor.tintColor = .systemPink
        
        counterClockButton.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        counterClockButton.strokeColor = .clear
        
        counterClockButton.alpha = 0.7
        //counterClockButton.strokeColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        //counterClockButton.blendMode = .screen
        //counterClockButton.lineWidth = 10
        counterClockButton.name = "counterClockWise"
        
        counterClockButton.fillTexture = SKTexture.init(image: imageLeft!)
        counterClockButton.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        counterClockButton.zPosition = 100
        self.addChild(counterClockButton)
        
        let clockButton = SKShapeNode()
        clockButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30)
        let imageRight = UIImage.init(systemName: "arrow.clockwise")
        clockButton.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        clockButton.strokeColor = .clear
        counterClockButton.alpha = 0.7
        //clockButton.blendMode = .screen
        //clockButton.lineWidth = 10
        clockButton.name = "clockButton"
        clockButton.fillTexture = SKTexture.init(image: imageRight!)
        clockButton.zPosition = 100
        self.addChild(clockButton)
        
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = CollisionCategory.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategory.Snake | CollisionCategory.SnakeHead
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockWise" || touchesNode.name == "clockButton" else {
                return
            }
            
            touchesNode.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            if touchesNode.name == "counterClockWise" {
                snake!.moveCOunterClockWise()
             //   view?.isPaused = true
            } else if touchesNode.name == "clockButton" {
                snake!.moveClockwise()
              //  view?.isPaused = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchesNode = self.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == "counterClockWise" || touchesNode.name == "clockButton" else {
                return
            }
            
            touchesNode.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5)))
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
}


var appleCount = 0

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes - CollisionCategory.SnakeHead
        
        switch collisionObject {
        case CollisionCategory.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            appleCount += 1
            createApple()
        case CollisionCategory.EdgeBody:
            //????
                  
self.removeAllChildren()
            view?.isPaused = true
            
            let alert = UIAlertController(title: "Game over", message: "You earn \(appleCount) apples.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try again!", style: .default, handler: { (action: UIAlertAction!) in
                            appleCount = 0
                            self.view?.isPaused = false
                            
                        
                        }))
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        didMove(to: view!)
            appleCount = 0
            
            break
        default:
            break
        
        }
    }
}
