//
//  ShopScene.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-15.
//

import UIKit
import SpriteKit

class ShopScene: SKScene {
    
    let backButton = SKLabelNode(text: "Back")
    var costLabel: SKLabelNode!

    
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
        }
    }
}
