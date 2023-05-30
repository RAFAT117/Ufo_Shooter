//
//  GameoverScene.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-12.
//
import SpriteKit
class GameoverScene: SKScene {
    
    let gameoverLabel =  SKLabelNode(text: "Game over")
    let highScoreLabel =  SKLabelNode(text: "High Score: 0")
    let coinScoreLabel =  SKLabelNode(text: "Coins: 0")
    let playAgainButtonText =  SKLabelNode(text: "Play again")
    let shopbuttonText =  SKLabelNode(text: "Shop")

    let playAgainButton = SKShapeNode(rect: CGRect(x: -150, y: -33, width: 300, height: 100), cornerRadius: 10)
    let shopbutton = SKShapeNode(rect: CGRect(x: -100, y: -26, width: 200, height: 75), cornerRadius: 10)

    

    override func didMove(to view: SKView) {
        backgroundColor = .systemBrown
        
        //game over text
        gameoverLabel.fontName = "HelveticaNeue-Bold"
        gameoverLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.8)
        gameoverLabel.fontSize = 60
        addChild(gameoverLabel)
        
        //highscore label + user highest score
        let highScore = UserDefaults.standard.integer(forKey: "highscore")
        highScoreLabel.text = "High Score: \(highScore)"
        highScoreLabel.fontName = "HelveticaNeue-Bold"
        highScoreLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.55)
        highScoreLabel.fontSize = 30
        addChild(highScoreLabel)
        
        // coins text + how much coins user have
        let coinscore = UserDefaults.standard.integer(forKey: "coin")
        coinScoreLabel.text = "Coins: \(coinscore)"
        coinScoreLabel.fontName = "HelveticaNeue-Bold"
        coinScoreLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.6)
        coinScoreLabel.fontSize = 30
        addChild(coinScoreLabel)
        
        //play again button
        playAgainButtonText.fontColor = .black
        playAgainButtonText.fontName = "HelveticaNeue-Bold"
        playAgainButtonText.position = CGPoint(x: frame.midX, y: self.size.height * 0.4)
        playAgainButtonText.fontSize = 50
        addChild(playAgainButtonText)
        
        playAgainButton.fillColor = SKColor.white
        playAgainButton.strokeColor = SKColor.black
        playAgainButton.lineWidth = 2
        playAgainButton.position = playAgainButtonText.position
        playAgainButton.zPosition = playAgainButtonText.zPosition - 1
        addChild(playAgainButton)
        
        //shop button
        shopbuttonText.fontColor = .black
        shopbuttonText.fontName = "HelveticaNeue-Bold"
        shopbuttonText.position = CGPoint(x: frame.midX, y: self.size.height * 0.3)
        shopbuttonText.fontSize = 42
        addChild(shopbuttonText)
        
        
        shopbutton.fillColor = SKColor.white
        shopbutton.strokeColor = SKColor.black
        shopbutton.position = shopbuttonText.position
        shopbutton.zPosition = shopbuttonText.zPosition - 1
        addChild(shopbutton)
    }
    
    //handle touches with buttons
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
