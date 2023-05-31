//
//  GameScene.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-06.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var scorelabel : SKLabelNode!
    var liveslabel : SKLabelNode!
    var bullets = [SKSpriteNode]()
    var enemies = [SKSpriteNode]()
    var coins = [SKSpriteNode]()
    var coinsLabel: SKLabelNode!
    var UFO = SKSpriteNode(imageNamed: "ufo")

    var score = 0
    var lives = 3
    var Onecoin = 0
    
    
    // Unique Category bitmask
    let playerCategory = UInt32(1)
    let enemyCategory = UInt32(2)
    let bulletCategory = UInt32(4)
    let coinCategory = UInt32(8)
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self // Set physics contact delegate

        // background
        let background = SKSpriteNode(imageNamed: "background")
        background.size = CGSize(width: self.size.width * 1.34, height: self.size.height * 1.34)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0;
        addChild(background)
        
        //score label
        scorelabel = SKLabelNode(text: "Score: \(score)")
        scorelabel.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.9)
        scorelabel.fontSize = 25
        scorelabel.zPosition = 100;
        scorelabel.fontName = "HelveticaNeue-Bold"
        addChild(scorelabel)
        
        //lives label
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
        
        // Create player
        let selectedplayer = UserDefaults.standard.string(forKey: "selectedplayer") ?? "ufo"
        UFO.texture = SKTexture(imageNamed: selectedplayer)
        UFO.position = CGPoint(x: frame.midX, y: UFO.size.height / 5)
        UFO.setScale(0.13)
        UFO.zPosition = 2;
        UFO.physicsBody = SKPhysicsBody(circleOfRadius: UFO.size.width/2)
        UFO.physicsBody?.isDynamic = false
        UFO.physicsBody?.categoryBitMask = playerCategory
        UFO.physicsBody?.contactTestBitMask = enemyCategory
        addChild(UFO)
        
        // Spawn enemies at regular intervals
        let spawn = SKAction.run(spawnEnemy)
        let wait = SKAction.wait(forDuration: 1.0)
        let sequence = SKAction.sequence([spawn, wait])
        let spawnForEver = SKAction.repeatForever(sequence)
        run(spawnForEver)
    }
    
    //spawn enemy from above
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
    
    // handle touches
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
    
    
    // Function called when a physics contact occurs between two bodies
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        // Collision between bullet and enemy
        if (firstBody.categoryBitMask == bulletCategory && secondBody.categoryBitMask == enemyCategory) ||
            (firstBody.categoryBitMask == enemyCategory && secondBody.categoryBitMask == bulletCategory) {
            
            if let bullet = bullets.first(where: { $0.physicsBody == firstBody || $0.physicsBody == secondBody }),
               let enemy = enemies.first(where: { $0.physicsBody == firstBody || $0.physicsBody == secondBody
                   // Find the specific bullet and enemy involved in the collision
               }) {
                
                bullet.removeFromParent()
                enemy.removeFromParent()
                bullets.removeAll(where: { $0 == bullet })
                enemies.removeAll(where: { $0 == enemy })
                score += 1
                scorelabel.text = "Score: \(score)"
                
                // add a chance for a coin to drop when an enemy is destroyed
                let random = arc4random_uniform(10) // generate a random number between 0 and 9
                if random < 3 { // 30% chance
                    let coin = SKSpriteNode(imageNamed: "coin")
                    coin.setScale(0.02)
                    coin.zPosition = 200
                    coin.position = enemy.position // set the coin's initial position to the enemy's position
                    coin.physicsBody = SKPhysicsBody(circleOfRadius: coin.size.width/2)
                    coin.physicsBody?.categoryBitMask = coinCategory
                    coin.physicsBody?.contactTestBitMask = playerCategory
                    addChild(coin) // add the coin to the scene
                    coins.append(coin)
                }
            }
            
            
            // Collision between enemy and player
        } else if (firstBody.categoryBitMask == enemyCategory && secondBody.categoryBitMask == playerCategory) ||
                    (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == enemyCategory) {
            if lives > 1 {
                // Player has more than 1 life remaining
                
                lives -= 1
                liveslabel.text = "Lives: \(lives)"
                if let enemy = enemies.first(where: { $0.physicsBody == firstBody || $0.physicsBody == secondBody }) {
                    enemy.removeFromParent()
                    enemies.removeAll(where: { $0 == enemy })
                    
                }
            } else {
                // Player has lost all lives

                lives = 0
                liveslabel.text = "Lives: \(lives)"
                UFO.removeFromParent()
                
                let highscore = UserDefaults.standard.integer(forKey: "highscore")
                if score > highscore {
                    UserDefaults.standard.set(score, forKey: "highscore")
                }
                
                let coinscore = UserDefaults.standard.integer(forKey: "coin")
                let newScore = coinscore + Onecoin
                UserDefaults.standard.set(newScore, forKey: "coin")
                
                
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
        // Collision between player and coin
        else if (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == coinCategory) ||
                    (firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == coinCategory) {
            
            // The player has collected a coin
            if let coin = coins.first(where: { $0.physicsBody == firstBody || $0.physicsBody == secondBody }) {
                coin.removeFromParent()
                coins.removeAll(where: { $0 == coin })
                Onecoin += 1 // Increment the coins count
                coinsLabel.text = "Coins: \(Onecoin)" // Update the label
            }
        }
    }
    
    // Function called every frame update
    override func update(_ currentTime: TimeInterval) {
        enemies.forEach { enemy in
            
            // Enemy has reached the bottom of the screen
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
                    
                    let coinscore = UserDefaults.standard.integer(forKey: "coin")
                    let newScore = coinscore + Onecoin
                    UserDefaults.standard.set(newScore, forKey: "coin")
                    
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
    
    // player can move left or right
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            UFO.position.x = location.x
        }
    }
}
