//
//  GameScene.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-06.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var UFO: SKSpriteNode!
    
    var scorelabel : SKLabelNode!
    var liveslabel : SKLabelNode!
    var bullets = [SKSpriteNode]()
    var enemies = [SKSpriteNode]()
    var coinsLabel: SKLabelNode!

    var score = 0
    var lives = 3
    var Onecoin = 0

    let playerCategory = UInt32(1)
    let enemyCategory = UInt32(2)
    let bulletCategory = UInt32(4)
    let coinCategory = UInt32(8)
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self

        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = CGSize(width: self.size.width * 1.34, height: self.size.height * 1.34)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0;
        addChild(background)
        
        scorelabel = SKLabelNode(text: "Score: \(score)")
        scorelabel.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.9)
        scorelabel.fontSize = 25
        scorelabel.zPosition = 100;
        scorelabel.fontName = "HelveticaNeue-Bold"
        addChild(scorelabel)
        
        liveslabel = SKLabelNode(text: "Lives: \(lives)")
        liveslabel.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.9)
        liveslabel.fontSize = 25
        liveslabel.fontName = "HelveticaNeue-Bold"
        liveslabel.zPosition = 100;
        addChild(liveslabel)
        
        // Set up coins label
        coinsLabel = SKLabelNode(text: "Coins: \(Onecoin)")
        coinsLabel.position = CGPoint(x: self.size.width * 0.50, y: self.size.height * 0.9)
        coinsLabel.zPosition = 200
        coinsLabel.fontName = "HelveticaNeue-Bold"
        addChild(coinsLabel)
     
        
        UFO = SKSpriteNode(imageNamed: "ufo")
        UFO.position = CGPoint(x: frame.midX, y: UFO.size.height / 5)
        UFO.setScale(0.13)
        UFO.zPosition = 2;
        UFO.physicsBody = SKPhysicsBody(circleOfRadius: UFO.size.width/2)
        UFO.physicsBody?.isDynamic = false
        UFO.physicsBody?.categoryBitMask = playerCategory
        UFO.physicsBody?.contactTestBitMask = enemyCategory
        

        addChild(UFO)
        
        let spawn = SKAction.run(spawnEnemy)
        let wait = SKAction.wait(forDuration: 1.0)
        let sequence = SKAction.sequence([spawn, wait])
        let spawnForEver = SKAction.repeatForever(sequence)
        run(spawnForEver)
    }
    
    func spawnEnemy(){
        let enemy = SKSpriteNode(imageNamed: "enemy")
        enemy.position = CGPoint(x: CGFloat.random(in: 0..<size.width), y: size.height)
        enemy.zPosition = 1
        enemy.setScale(0.1)
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.width/2)
        enemy.physicsBody?.categoryBitMask = enemyCategory
        enemy.physicsBody?.contactTestBitMask = bulletCategory
        addChild(enemy)
        enemies.append(enemy)
        
        let moveDown = SKAction.move(to: CGPoint (x: enemy.position.x, y: -enemy.size.height), duration: 3.0)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveDown, remove])
        enemy.run(sequence)

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let bullet = SKSpriteNode(imageNamed: "bullet")
            bullet.position = UFO.position
            bullet.setScale(0.08)
            bullet.zPosition = 15
            bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
            bullet.physicsBody?.categoryBitMask = bulletCategory
            bullet.physicsBody?.contactTestBitMask = enemyCategory
            addChild(bullet)
            bullets.append(bullet)
            
            let move = SKAction.move(to: CGPoint(x: location.x, y: self.size.height + bullet.size.height), duration: 1.0)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move,remove])
            bullet.run(sequence)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if (firstBody.categoryBitMask == bulletCategory && secondBody.categoryBitMask == enemyCategory) ||
            (firstBody.categoryBitMask == enemyCategory && secondBody.categoryBitMask == bulletCategory) {
            
            if let bullet = bullets.first(where: { $0.physicsBody == firstBody || $0.physicsBody == secondBody }),
               let enemy = enemies.first(where: { $0.physicsBody == firstBody || $0.physicsBody == secondBody }) {
                bullet.removeFromParent()
                enemy.removeFromParent()
                bullets.removeAll(where: { $0 == bullet })
                enemies.removeAll(where: { $0 == enemy })
                score += 1
                scorelabel.text = "Score: \(score)"
            }
            
            
        } else if (firstBody.categoryBitMask == enemyCategory && secondBody.categoryBitMask == playerCategory) ||
                    (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == enemyCategory) {
            if lives > 1 {
                
                lives -= 1
                liveslabel.text = "Lives: \(lives)"
                if let enemy = enemies.first(where: { $0.physicsBody == firstBody || $0.physicsBody == secondBody }) {
                    enemy.removeFromParent()
                    enemies.removeAll(where: { $0 == enemy })

                }
            } else {
                lives = 0
                liveslabel.text = "Lives: \(lives)"
                UFO.removeFromParent()
                
                let highscore = UserDefaults.standard.integer(forKey: "highscore")
                if score > highscore {
                    UserDefaults.standard.set(score, forKey: "highscore")
                }
                
                let gameover  = GameoverScene(size: size)
                gameover.scaleMode = scaleMode
                view?.presentScene(gameover)
                
                
                isPaused = true
                removeAllActions()
                bullets.forEach { $0.removeFromParent() }
                enemies.forEach { $0.removeFromParent() }
                bullets.removeAll()
                enemies.removeAll()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        enemies.forEach { enemy in
            if enemy.position.y <= 0 {
                enemy.removeFromParent()
                enemies.removeAll(where: { $0 == enemy })
                if lives > 1 {
                    lives -= 1
                    liveslabel.text = "Lives: \(lives)"
                } else {
                    lives = 0
                    liveslabel.text = "Lives: \(lives)"
                    UFO.removeFromParent()
                    
                    let highscore = UserDefaults.standard.integer(forKey: "highscore")
                    if score > highscore {
                        UserDefaults.standard.set(score, forKey: "highscore")
                    }
                    
                    let gameover  = GameoverScene(size: size)
                    gameover.scaleMode = scaleMode
                    view?.presentScene(gameover)
                    
                    isPaused = true
                    removeAllActions()
                    bullets.forEach { $0.removeFromParent() }
                    enemies.forEach { $0.removeFromParent() }
                    bullets.removeAll()
                    enemies.removeAll()
                }
                
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            UFO.position.x = location.x
        }
    }
}
