//
//  DiscoBallNode.swift
//  CatNap
//
//  Created by hs on 2018/12/22.
//  Copyright © 2018年 hs. All rights reserved.
//

import SpriteKit
import AVFoundation
class DiscoBallNode: SKSpriteNode, EventListenerNode,
InteractiveNode {
    private var player: AVPlayer!
    private var video: SKVideoNode!
    static private(set) var isDiscoTime = false
    private var isDiscoTime: Bool = false {
        didSet {
            video.isHidden = !isDiscoTime
            SKTAudio.sharedInstance().playBackgroundMusic(isDiscoTime ? "disco-sound.m4a" : "backgroundMusic.mp3")
            if isDiscoTime {
                video.run(SKAction.wait(forDuration: 5.0),
                          completion: {self.isDiscoTime = false})
            }
            if isDiscoTime {
                video.play()
                run(spinAction)
            } else {
                video.pause()
                removeAllActions()
            }
            DiscoBallNode.isDiscoTime = isDiscoTime
        }
    }
    private let spinAction = SKAction.repeatForever(
        SKAction.animate(with: [SKTexture(imageNamed: "discoball1"),
                                SKTexture(imageNamed: "discoball2"),
                                SKTexture(imageNamed: "discoball3")],
                         timePerFrame: 0.2))
    func didMoveToScene() {
        isUserInteractionEnabled = true
        let fileUrl = Bundle.main.url(forResource: "discolights-loop", withExtension: "mov")!
        player = AVPlayer(url: fileUrl)
        video = SKVideoNode(avPlayer: player)
        
        video.size = scene!.size
        video.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY)
        video.zPosition = -1
        scene!.addChild(video)
        video.alpha = 0.75
        
        video.isHidden = true
        video.pause()
        NotificationCenter.default.addObserver(self, selector: #selector(didReachEndOfVideo), name:Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        

    }
    
    @objc func didReachEndOfVideo() {
        print("rewind!")
        player.currentItem!.seek(to: kCMTimeZero) { [weak self] _ in
            self?.player.play()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        interact() }
    func interact() {
        if !isDiscoTime {
            isDiscoTime = true
        }
    }
}
