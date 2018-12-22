//
//  StoneNode.swift
//  CatNap
//
//  Created by hs on 2018/12/22.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit
class StoneNode: SKSpriteNode, EventListenerNode,
InteractiveNode {
    static func makeCompoundNode(in scene: SKScene) -> SKNode {
        let compound = StoneNode()
        
        for child in scene.children
        .filter({node in node is StoneNode}) {
            child.removeFromParent()
            compound.addChild(child)
        }
        
        let bodies = compound.children.map({node in
            SKPhysicsBody(rectangleOf: node.frame.size, center: node.position)
        })
        
        compound.physicsBody = SKPhysicsBody(bodies: bodies)
        compound.physicsBody!.categoryBitMask = PhysicsCategory.Block
        compound.physicsBody!.collisionBitMask = PhysicsCategory.Edge | PhysicsCategory.Cat | PhysicsCategory.Block
        compound.isUserInteractionEnabled = true
        compound.zPosition = 1
        
        return compound
    }
    func didMoveToScene() {
        guard let scene = scene else {
            return
        }
        if parent == scene {
            scene.addChild(StoneNode.makeCompoundNode(in: scene))
        }
    }
    func interact() {
        isUserInteractionEnabled = false
        run(SKAction.sequence([
            SKAction.playSoundFileNamed("pop.mp3",waitForCompletion: false),
            SKAction.removeFromParent()
            ]))
    }
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
}
