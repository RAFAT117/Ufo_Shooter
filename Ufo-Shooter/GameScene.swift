//
//  GameScene.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-06.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var UFO: SKSpriteNode!
    
    var scorelabel : SKLabelNode!
    var liveslabel : SKLabelNode!

    var score = 0
    var lives = 3
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0;
        addChild(background)
        
        scorelabel = SKLabelNode(text: "Score: \(score)")
        scorelabel.position = CGPoint(x: self.size.width * 0.28, y: self.size.height * 0.9)
        scorelabel.fontSize = 55
        scorelabel.zPosition = 100;
        addChild(scorelabel)
        
        liveslabel = SKLabelNode(text: "Lives: \(lives)")
        liveslabel.position = CGPoint(x: self.size.width * 0.72, y: self.size.height * 0.9)
        liveslabel.fontSize = 55
        liveslabel.zPosition = 100;
        addChild(liveslabel)
        
     
        
        UFO = SKSpriteNode(imageNamed: "ufo")
        UFO.position = CGPoint(x: frame.midX, y: UFO.size.height / 2)
        UFO.setScale(0.3)
        UFO.zPosition = 2;
        addChild(UFO)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            UFO.position.x = location.x
        }
    }
}
