//
//  PictureNode.swift
//  CatNap
//
//  Created by hs on 2018/12/22.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit
class PictureNode: SKSpriteNode, EventListenerNode,
InteractiveNode {
    func didMoveToScene() {
        isUserInteractionEnabled = true
        let pictureNode = SKSpriteNode(imageNamed: "picture")
        let maskNode = SKSpriteNode(imageNamed: "picture-frame-mask")
        let cropNode = SKCropNode()
        cropNode.addChild(pictureNode)
        cropNode.maskNode = maskNode
        addChild(cropNode)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
    func interact() {
        isUserInteractionEnabled = false
        physicsBody!.isDynamic = true
    }
}
