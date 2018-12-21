//
//  MessageNode.swift
//  CatNap
//
//  Created by hs on 2018/12/21.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit
class MessageNode: SKLabelNode {
    var countCollisionWithEdge = 0
    convenience init(message: String) {
        self.init(fontNamed: "AvenirNext-Regular")
        text = message
        fontSize = 256.0
        fontColor = SKColor.gray
        zPosition = 100
        let front = SKLabelNode(fontNamed: "AvenirNext-Regular")
        front.text = message
        front.fontSize = 256.0
        front.fontColor = SKColor.white
        front.position = CGPoint(x: -2, y: -2)
        addChild(front)
        
        physicsBody = SKPhysicsBody(circleOfRadius: 10)
        physicsBody!.categoryBitMask = PhysicsCategory.Label
        physicsBody!.collisionBitMask = PhysicsCategory.Edge
        physicsBody!.contactTestBitMask = PhysicsCategory.Edge
        physicsBody!.restitution = 0.7
    }
    
    
}
