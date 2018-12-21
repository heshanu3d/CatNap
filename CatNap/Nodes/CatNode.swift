//
//  CatNode.swift
//  CatNap
//
//  Created by hs on 2018/12/21.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    static let kCatTappedNotification = "kCatTappedNotification"
    func didMoveToScene() {
        isUserInteractionEnabled = true
        
        let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
        parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture,
                                            size: catBodyTexture.size())
        parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
        parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge | PhysicsCategory.Spring
        parent!.physicsBody!.contactTestBitMask = PhysicsCategory.Bed | PhysicsCategory.Edge 
        isPaused = false
    }
    
    func interact() {
        NotificationCenter.default.post(Notification(name: NSNotification.Name(CatNode.kCatTappedNotification),
                                                     object: nil))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
    
    func wakeUp() {
        // 1
        for child in children {
            child.removeFromParent()
        }
        texture = nil
        color = SKColor.clear
        // 2
        let catAwake = SKSpriteNode(
            fileNamed: "CatWakeUp")!.childNode(withName: "cat_awake")!
        // 3
        catAwake.move(toParent: self)
        catAwake.position = CGPoint(x: -30, y: 100)
        catAwake.isPaused = false
    }
    
    func curlAt(scenePoint: CGPoint) {
        parent!.physicsBody = nil
        for child in children {
            child.removeFromParent()
        }
        texture = nil
        color = SKColor.clear
        let catCurl = SKSpriteNode(
            fileNamed: "CatCurl")!.childNode(withName: "cat_curl")!
        catCurl.move(toParent: self)
        catCurl.isPaused = false
        catCurl.position = CGPoint(x: -30, y: 100)
        
        var localPoint = convert(scenePoint, from: scene!)
        localPoint.y -= frame.size.height/3
        localPoint.x += 50
        run(SKAction.group([
            SKAction.move(to: localPoint, duration: 0.66),
            SKAction.rotate(toAngle: -parent!.zRotation, duration: 0.5)
            ]))
    }
}
