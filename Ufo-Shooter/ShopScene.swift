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
    
    override func didMove(to view: SKView) {
        backgroundColor = .systemBrown

        
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
