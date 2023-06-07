//
//  ShopScene.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-15.
//sss
 //d
import UIKit
import SpriteKit


class ShopScene: SKScene {
    
    let backButtonText = SKLabelNode(text: "Back")
    var costLabel: SKLabelNode!
    let backButton = SKShapeNode(rect: CGRect(x: -100, y: -23, width: 200, height: 75), cornerRadius: 10)


    let ship1 = SKSpriteNode(imageNamed: "ship1")
    let ship2 = SKSpriteNode(imageNamed: "ship2")
    let ship3 = SKSpriteNode(imageNamed: "ship3")
    var coinScoreLabel =  SKLabelNode(text: "Coins: 0")
    let UFO = SKSpriteNode(imageNamed: "ufo")

    var selectedCharacter = "ufo"


    override func didMove(to view: SKView) {
        backgroundColor = .systemBrown

        //coin label + how much coins the user have
        let coinscore = UserDefaults.standard.integer(forKey: "coin")
        coinScoreLabel.text = "Coins: \(coinscore)"
        coinScoreLabel.fontName = "HelveticaNeue-Bold"
        coinScoreLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.8)
        coinScoreLabel.fontSize = 50
        addChild(coinScoreLabel)
        
        // cost label, how much ships cost
        costLabel = SKLabelNode(text: "Cost : 50 coins")
        costLabel.fontName = "HelveticaNeue-Bold"
        costLabel.fontSize = 30
        costLabel.fontColor = SKColor.black
        costLabel.position = CGPoint(x: frame.midX, y: self.size.height * 0.73)
        addChild(costLabel)
        
        //ship nr1
        ship1.name = "ship1"
        ship1.setScale(0.80)
        ship1.position = CGPoint(x: self.size.width * 0.30, y: self.size.height * 0.6)
        addChild(ship1)
        
        //ship nr3
        ship2.name = "ship2"
        ship2.setScale(0.15)
        ship2.position = CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.6)
        addChild(ship2)
        
        //ship nr3
        ship3.name = "ship3"
        ship3.setScale(0.2)
        ship3.position = CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.4)
        addChild(ship3)
        
        //Ufo ship
        UFO.name = "ufo"
        UFO.setScale(0.2)
        UFO.position = CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.4)
        addChild(UFO)
       
        
        
        // Create a "back" button to return to the main menu
        backButtonText.name = "backButton"
        backButtonText.fontName = "AvenirNext-Bold"
        backButtonText.fontSize = 45
        backButtonText.fontColor = SKColor.black
        backButtonText.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        addChild(backButtonText)
        
        backButton.fillColor = SKColor.white
        backButton.strokeColor = SKColor.black
        backButton.position = backButtonText.position
        backButton.zPosition = backButtonText.zPosition - 1
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
            if ship1.frame.contains(location) || ship2.frame.contains(location) || ship3.frame.contains(location) || UFO.frame.contains(location) {
                let cost = 50
                let coinscore = UserDefaults.standard.integer(forKey: "coin")
                
                if coinscore >= cost {
                    UserDefaults.standard.set(coinscore - cost, forKey: "coin")
                    coinScoreLabel.text = "Coins: \(coinscore - cost)"
                    
                    
                    if ship1.frame.contains(location){
                        selectedCharacter = "ship1"
                    } else  if ship2.frame.contains(location){
                        selectedCharacter = "ship2"
                    } else  if ship3.frame.contains(location){
                        selectedCharacter = "ship3"
                    }else  if UFO.frame.contains(location){
                        selectedCharacter = "ufo"
                    }
                    UserDefaults.standard.set(selectedCharacter, forKey: "selectedplayer")
                }
            }
        }
    }
}
