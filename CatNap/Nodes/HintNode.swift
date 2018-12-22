//
//  HintNode.swift
//  CatNap
//
//  Created by hs on 2018/12/22.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit
class HintNode: SKSpriteNode, EventListenerNode, InteractiveNode {
    var arrowPath: CGPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.5, y: 65.69))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 1.5))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 38.66))
        bezierPath.addLine(to: CGPoint(x: 257.5, y: 38.66))
        bezierPath.addLine(to: CGPoint(x: 257.5, y: 92.72))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 92.72))
        bezierPath.addLine(to: CGPoint(x: 74.99, y: 126.5))
        bezierPath.addLine(to: CGPoint(x: 0.5, y: 65.69))
        bezierPath.close()
        return bezierPath.cgPath
    }()
    var arrowColor = [SKColor.black,SKColor.blue,SKColor.brown,SKColor.cyan,SKColor.green,SKColor.yellow]
    var shape : SKShapeNode!
    func didMoveToScene() {
        isUserInteractionEnabled = true
        color = SKColor.clear
        shape = SKShapeNode(path: arrowPath)
        shape.strokeColor = SKColor.gray
        shape.lineWidth = 4
        shape.fillColor = SKColor.white
        shape.name = "hintNode"
        addChild(shape)
        shape.fillTexture = SKTexture(imageNamed: "wood_tinted")
        shape.alpha = 0.8
        
        let move = SKAction.moveBy(x: -40, y: 0, duration: 1.0)
        let bounce = SKAction.sequence([
            move, move.reversed()
            ])
        let bounceAction = SKAction.repeat(bounce, count: 3)
        shape.run(bounceAction, completion: {
            self.removeFromParent()
        })
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact()
    }
    func interact() {
        shape.fillColor = arrowColor[Int.random(min: 0, max: arrowColor.count - 1)]
    }
}
