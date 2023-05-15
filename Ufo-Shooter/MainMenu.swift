//
//  MainMenu.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-06.
//

import SpriteKit

let startbutton =  SKLabelNode(text: "Start Game")
let shopbutton =  SKLabelNode(text: "Shop")


class MainMenu: SKScene {
    
    override func didMove(to view: SKView) {
        
        startbutton.fontColor = .white
        startbutton.position = CGPoint(x: frame.midX, y: self.size.height * 0.5)
        startbutton.fontSize = 50
        startbutton.fontName = "HelveticaNeue-Bold"
        startbutton.name = "Start Game"
        startbutton.zPosition = 2;
        addChild(startbutton)
        
        shopbutton.fontColor = .white
        shopbutton.position = CGPoint(x: frame.midX, y: self.size.height * 0.4)
        shopbutton.fontSize = 40
        shopbutton.fontName = "HelveticaNeue-Bold"
        shopbutton.name = "Shop"
        shopbutton.zPosition = 2;

        addChild(shopbutton)
        
        let UFObackground = SKSpriteNode(imageNamed: "ufo")
        UFObackground.size = self.size
        UFObackground.position = CGPoint(x: frame.midX, y: self.size.height / 5)
        UFObackground.setScale(0.2)
        UFObackground.zPosition = 1;
        addChild(UFObackground)
        
        let background = SKSpriteNode(color: SKColor.systemBrown, size: self.size)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            if startbutton.contains(location) {
                
                let GoToscene = GameScene(size: self.size)
                GoToscene.scaleMode = self.scaleMode
                view?.presentScene(GoToscene)
            } else if shopbutton.contains(location) {
                
                let GoToshop = ShopScene(size: self.size)
                GoToshop.scaleMode = self.scaleMode
                view?.presentScene(GoToshop)
            }
            
        }
    }
  

}
