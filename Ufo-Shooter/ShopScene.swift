//
//  ShopScene.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-15.
//
 //d
import UIKit
import SpriteKit

class ShopScene: SKScene {
    
    let backButton = SKLabelNode(text: "Back")
    var costLabel: SKLabelNode!

    let ship1 = SKSpriteNode(imageNamed: "ship1")
    let ship2 = SKSpriteNode(imageNamed: "ship2")
    let ship3 = SKSpriteNode(imageNamed: "ship3")
    var coinScoreLabel =  SKLabelNode(text: "Coins: 0")

    override func didMove(to view: SKView) {
        backgroundColor = .systemBrown

        let coinscore = UserDefaults.standard.integer(forKey: "coin")
        coinScoreLabel.text = "Coins: \(coinscore)"
        coinScoreLabel.fontName = "HelveticaNeue-Bold"
        coinScoreLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.8)
        coinScoreLabel.fontSize = 30
        addChild(coinScoreLabel)
        
        costLabel = SKLabelNode(text: "Cost : 50 coins")
        costLabel.fontName = "HelveticaNeue-Bold"
        costLabel.fontSize = 30
        costLabel.fontColor = SKColor.black
        costLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.7)
        addChild(costLabel)
        
        ship1.name = "ship1"
        ship1.setScale(0.80)
        ship1.position = CGPoint(x: self.size.width * 0.30, y: self.size.height * 0.6)
        addChild(ship1)
        
        ship2.name = "ship2"
        ship2.setScale(0.15)
        ship2.position = CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.6)
        addChild(ship2)
        
        ship3.name = "ship3"
        ship3.setScale(0.2)
        ship3.position = CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.4)
        addChild(ship3)
       
        
        
        // Create a "back" button to return to the main menu
        backButton.name = "backButton"
        backButton.fontName = "AvenirNext-Bold"
        backButton.fontSize = 30
        backButton.fontColor = SKColor.black
        backButton.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        addChild(backButton)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // Handle the "back" button
            if backButton.frame.contains(location) {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let mainMenuScene = MainMenu(size: self.size)
                mainMenuScene.scaleMode = scaleMode
                view?.presentScene(mainMenuScene, transition: transition)
            }
            
            // Handle the purchase of a character
            if ship1.frame.contains(location) || ship2.frame.contains(location) || ship3.frame.contains(location) {
                let cost = 1
                let coinscore = UserDefaults.standard.integer(forKey: "coin")
                
                if coinscore >= cost {
                    UserDefaults.standard.set(coinscore - cost, forKey: "coin")
                    coinScoreLabel.text = "Coins: \(coinscore - cost)"
                }
            }
        }
    }
}
