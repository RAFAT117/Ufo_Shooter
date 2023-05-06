//
//  MainMenu.swift
//  Ufo-Shooter
//
//  Created by Rafaat.Al-Badri on 2023-05-06.
//

import SpriteKit

class MainMenu: SKScene {
    
    override func didMove(to view: SKView) {
        let startbutton = SKLabelNode(text: "Start Game")
        startbutton.fontColor = .white
        startbutton.position = CGPoint(x: frame.midX, y: frame.midY)
        startbutton.fontSize = 130
        startbutton.name = "Start Game"
        addChild(startbutton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            let nodes = nodes(at: location)
            print(nodes)
            if nodes.contains(where: { $0 is SKLabelNode && $0.name == "Start Game" }) {
                let GoToscene = GameScene(size: self.size)
                GoToscene.scaleMode = self.scaleMode
                view?.presentScene(GoToscene)
            }
            
        }
    }
  

}
