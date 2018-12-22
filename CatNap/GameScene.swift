//
//  GameScene.swift
//  CatNap
//
//  Created by hs on 2018/12/20.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None:  UInt32 = 0
    static let Cat:   UInt32 = 0b1 // 1
    static let Block: UInt32 = 0b10 // 2
    static let Bed:   UInt32 = 0b100 // 4
    static let Edge:  UInt32 = 0b1000 // 8
    static let Label: UInt32 = 0b10000 // 16
    static let Spring: UInt32 = 0b100000 // 32
    static let Hook: UInt32 = 0b1000000 // 64
    static let Seesaw: UInt32 = 0b10000000 // 128
}

protocol EventListenerNode {
    func didMoveToScene()
}
protocol InteractiveNode {
    func interact()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bedNode: BedNode!
    var catNode: CatNode!
    var playable = true
    var hookBaseNode: HookBaseNode?
    var seesawNode : SeesawNode?
    var hintNode : HintNode?
    var currentLevel: Int = 0
    
    override func didMove(to view: SKView) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height
            - maxAspectRatioHeight)/2
        let playableRect = CGRect(x: 0, y: playableMargin,
                                  width: size.width, height: size.height-playableMargin*2)
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        physicsWorld.contactDelegate = self
        physicsBody!.categoryBitMask = PhysicsCategory.Edge
        
        enumerateChildNodes(withName: "//*", using: { node, _ in
            if let eventListenerNode = node as? EventListenerNode{
                eventListenerNode.didMoveToScene()
            }
        })
        bedNode = childNode(withName: "bed") as! BedNode
        catNode = childNode(withName: "//cat_body") as! CatNode
        SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
        hookBaseNode = childNode(withName: "hookBase") as? HookBaseNode
        seesawNode = childNode(withName: "Seesaw") as? SeesawNode
        hintNode = childNode(withName: "hint") as? HintNode

    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == PhysicsCategory.Label | PhysicsCategory.Edge {
            var count = 0
            let node : MessageNode
            if contact.bodyA.categoryBitMask == PhysicsCategory.Label {
                node = contact.bodyA.node as! MessageNode
            }else{
                node = contact.bodyB.node as! MessageNode
            }
            count = node.countCollisionWithEdge
            if count < 1 {
                node.countCollisionWithEdge += 1
            }else {
                node.removeFromParent()
            }
        }
        if !playable && hookBaseNode?.isHooked != true{
            return
        }
        if collision == PhysicsCategory.Cat | PhysicsCategory.Bed {
            playable = false
            win()
        }else if collision == PhysicsCategory.Cat | PhysicsCategory.Edge {
            playable = false
            lose()
        }
        if collision == PhysicsCategory.Hook | PhysicsCategory.Cat && hookBaseNode?.isHooked == false {
            hookBaseNode?.hookCat(catPhysicsBody: catNode.parent!.physicsBody!)
        }else if collision == PhysicsCategory.Seesaw | PhysicsCategory.Cat && seesawNode?.isCatSlipe == false {
            seesawNode?.isCatSlipe = true
        }
    }
    
    override func didSimulatePhysics() {
        if playable {
            if abs(catNode.parent!.zRotation) >
                CGFloat(25).degreesToRadians() {
                playable = false
                lose() }
        }
    }
    
    func inGameMessage(text: String) {
        let message = MessageNode(message: text)
        message.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(message)
    }
    
    func newGame() {
        let transition = SKTransition.doorway(withDuration: 1.0)
        
        let scene = GameScene.level(levelNum: currentLevel)
        view!.presentScene(scene!, transition: transition)
        
    }
    
    func lose() {
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        SKTAudio.sharedInstance().playSoundEffect("lose.mp3")
        inGameMessage(text: "Try again...")
        run(SKAction.afterDelay(5, runBlock: newGame))
        catNode.wakeUp()
    }
    
    func win() {
        if currentLevel < 6 {
            currentLevel += 1
        }
        playable = false
        SKTAudio.sharedInstance().pauseBackgroundMusic()
        SKTAudio.sharedInstance().playSoundEffect("win.mp3")
        inGameMessage(text: "Nice job!")
        run(SKAction.afterDelay(3, runBlock: newGame))
        catNode.curlAt(scenePoint: bedNode.position)
    }
    
    class func level(levelNum: Int) -> GameScene? {
        let scene = GameScene(fileNamed: "Level\(levelNum)")!
        scene.currentLevel = levelNum
        scene.scaleMode = .aspectFill
        return scene
    }
}

