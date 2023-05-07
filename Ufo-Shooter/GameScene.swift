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
    var bullets = [SKSpriteNode]()

    var score = 0
    var lives = 3
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = CGSize(width: self.size.width * 1.34, height: self.size.height * 1.34)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0;
        addChild(background)
        
        scorelabel = SKLabelNode(text: "Score: \(score)")
        scorelabel.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.9)
        scorelabel.fontSize = 25
        scorelabel.zPosition = 100;
        addChild(scorelabel)
        
        liveslabel = SKLabelNode(text: "Lives: \(lives)")
        liveslabel.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.9)
        liveslabel.fontSize = 25
        liveslabel.zPosition = 100;
        addChild(liveslabel)
        
     
        
        UFO = SKSpriteNode(imageNamed: "ufo")
        UFO.position = CGPoint(x: frame.midX, y: UFO.size.height / 5)
        UFO.setScale(0.13)
        UFO.zPosition = 2;
        addChild(UFO)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let bullet = SKSpriteNode(imageNamed: "bullet")
            bullet.position = UFO.position
            bullet.setScale(0.08)
            bullet.zPosition = 15
            addChild(bullet)
            bullets.append(bullet)
            
            let move = SKAction.move(to: CGPoint(x: location.x, y: self.size.height + bullet.size.height), duration: 1.0)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move,remove])
            bullet.run(sequence)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            UFO.position.x = location.x
        }
    }
}
