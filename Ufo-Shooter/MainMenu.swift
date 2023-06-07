//
//  MainMenu.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-06.
//

import SpriteKit


//Start Screen

class MainMenu: SKScene {
    
    let startbuttonText =  SKLabelNode(text: "Start Game")
    let shopbuttonText =  SKLabelNode(text: "Shop")
    let GameNameText =  SKLabelNode(text: "Ufo Shooter")
    let startbutton = SKShapeNode(rect: CGRect(x: -150, y: -33, width: 300, height: 100), cornerRadius: 10)
    let shopbutton = SKShapeNode(rect: CGRect(x: -100, y: -26, width: 200, height: 75), cornerRadius: 10)


   
    override func didMove(to view: SKView) {
        backgroundColor = .systemBrown

        //Game name text
        GameNameText.fontColor = .white
        GameNameText.position = CGPoint(x: frame.midX, y: self.size.height * 0.75)
        GameNameText.fontSize = 60
        GameNameText.fontName = "HelveticaNeue-Bold"
        GameNameText.name = "Ufo Shooter"
        GameNameText.zPosition = 2;
        addChild(GameNameText)
        
        //Start button
        startbuttonText.fontColor = .black
        startbuttonText.position = CGPoint(x: frame.midX, y: self.size.height * 0.465)
        startbuttonText.fontSize = 52.5
        startbuttonText.fontName = "HelveticaNeue-Bold"
        startbuttonText.name = "Start Game"
        startbuttonText.zPosition = 2;
        addChild(startbuttonText)
        
        startbutton.fillColor = SKColor.white
        startbutton.strokeColor = SKColor.black
        startbutton.lineWidth = 2
        startbutton.position = startbuttonText.position
        startbutton.zPosition = startbuttonText.zPosition - 1
        addChild(startbutton)
        
        //Shop button
        shopbuttonText.fontColor = .black
        shopbuttonText.position = CGPoint(x: frame.midX, y: self.size.height * 0.35)
        shopbuttonText.fontSize = 40
        shopbuttonText.fontName = "HelveticaNeue-Bold"
        shopbuttonText.name = "Shop"
        shopbuttonText.zPosition = 2;
        addChild(shopbuttonText)
        
        shopbutton.fillColor = SKColor.white
        shopbutton.strokeColor = SKColor.black
        shopbutton.position = shopbuttonText.position
        shopbutton.zPosition = shopbuttonText.zPosition - 1
        addChild(shopbutton)
        
        
        
        //Ufo player pic
        let UFObackground = SKSpriteNode(imageNamed: "ufo")
        UFObackground.size = self.size
        UFObackground.position = CGPoint(x: frame.midX, y: self.size.height / 6.5)
        UFObackground.xScale = 0.35
        UFObackground.yScale = 0.18
        UFObackground.zPosition = 1;
        addChild(UFObackground)
        
  
    }
    
    // User Touches screen
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
