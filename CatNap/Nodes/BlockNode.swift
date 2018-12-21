//
//  BlockNode.swift
//  CatNap
//
//  Created by hs on 2018/12/21.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit
class BlockNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    func didMoveToScene() {
        isUserInteractionEnabled = true
    }
    func interact() {
        isUserInteractionEnabled = false
        run(SKAction.sequence([SKAction.playSoundFileNamed("pop.mp3",waitForCompletion: false),
                               SKAction.scale(to: 0.8, duration: 0.1),
                               SKAction.removeFromParent()]))
    }
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("destroy block")
        interact()
    }
}
