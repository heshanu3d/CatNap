//
//  SeesawBaseNode.swift
//  CatNap
//
//  Created by hs on 2018/12/22.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit
class SeesawNode: SKSpriteNode, EventListenerNode, InteractiveNode{
    var isCatSlipe : Bool = false
    var pinJoint : SKPhysicsJointPin!
    var isDestroy : Bool = false
    func didMoveToScene() {
        isUserInteractionEnabled = true
        guard let scene = scene else {
            return
        }
        let seesawBaseNode = scene.childNode(withName: "seesawBase")
     pinJoint = SKPhysicsJointPin.joint(withBodyA: seesawBaseNode!.physicsBody!, bodyB: physicsBody!, anchor: position)
        scene.physicsWorld.add(pinJoint)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
    func interact() {
        if isCatSlipe && !isDestroy{
            isDestroy = true
            destroySeesaw()
        }
    }
    func destroySeesaw(){
        run(SKAction.sequence([SKAction.playSoundFileNamed("pop.mp3",waitForCompletion: false),
                               SKAction.scale(to: 0.8, duration: 0.1),
                               SKAction.removeFromParent()]))
        scene!.physicsWorld.remove(pinJoint)
        pinJoint = nil
    }
}
