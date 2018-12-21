//
//  BedNode.swift
//  CatNap
//
//  Created by hs on 2018/12/21.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit
class BedNode: SKSpriteNode, EventListenerNode {
    func didMoveToScene(){
        let bedBodySize = CGSize(width: 40, height: 30)
        physicsBody = SKPhysicsBody(rectangleOf: bedBodySize)
        physicsBody!.isDynamic = false
        physicsBody!.categoryBitMask = PhysicsCategory.Bed
        physicsBody!.collisionBitMask = PhysicsCategory.None
    }
    
}
