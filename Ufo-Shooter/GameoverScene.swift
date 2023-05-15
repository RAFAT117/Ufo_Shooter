//
//  GameoverScene.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-12.
//
import SpriteKit
class GameoverScene: SKScene {
    
    let gameoverLabel =  SKLabelNode(text: "Game over")
    let highScoreLabel =  SKLabelNode(text: "High score: 0")
    let coinScoreLabel =  SKLabelNode(text: "Coins: 0")
    let playAgainButton =  SKLabelNode(text: "Play again")
    let shopbutton =  SKLabelNode(text: "Shop")

    

    override func didMove(to view: SKView) {
        backgroundColor = .systemBrown
        
        gameoverLabel.fontName = "HelveticaNeue-Bold"
        gameoverLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.8)
        gameoverLabel.fontSize = 50
        addChild(gameoverLabel)
        
        highScoreLabel.fontName = "HelveticaNeue-Bold"
        highScoreLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.55)
        highScoreLabel.fontSize = 30
        addChild(highScoreLabel)
        
        coinScoreLabel.fontName = "HelveticaNeue-Bold"
        coinScoreLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.6)
        coinScoreLabel.fontSize = 30
        addChild(coinScoreLabel)
        
        playAgainButton.fontName = "HelveticaNeue-Bold"
        playAgainButton.position = CGPoint(x: frame.midX, y: self.size.height * 0.4)
        playAgainButton.fontSize = 42
        addChild(playAgainButton)
        
        shopbutton.fontName = "HelveticaNeue-Bold"
        shopbutton.position = CGPoint(x: frame.midX, y: self.size.height * 0.3)
        shopbutton.fontSize = 42
        addChild(shopbutton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if playAgainButton.contains(location){
                
                let gameScene = GameScene(size: size)
                gameScene.scaleMode = scaleMode
                view?.presentScene(gameScene)
            } else if shopbutton.contains(location) {
                
                let GoToshop = ShopScene(size: self.size)
                GoToshop.scaleMode = self.scaleMode
                view?.presentScene(GoToshop)
            }
        }
    }
}
