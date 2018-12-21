//
//  GameViewController.swift
//  CatNap
//
//  Created by hs on 2018/12/20.
//  Copyright © 2018年 hs. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
            if let scene = GameScene.level(levelNum: 2) {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = false
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }

//    override var shouldAutorotate: Bool {
//        return true
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Release any cached data, images, etc that aren't in use.
//    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
