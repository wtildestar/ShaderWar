//
//  BestScene.swift
//  ShaderWar
//
//  Created by wtildestar on 16/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class BestScene: ParentScene {
    
    var places = [10, 100, 1000]
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        setHeader(withName: "best", andBackground: "buttonBackground")
        
        let back = ButtonNode(titled: "back", backgroundName: "buttonBackground")
        back.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
        back.name = "back"
        back.label.name = "back"
        back.setScale(0.1)
        addChild(back)
        
        let topPlaces = places.sorted { $0 > $1 }.prefix(3)
        for (index, value) in topPlaces.enumerated() {
            let l = SKLabelNode(text: value.description)
            l.fontColor = UIColor(red: 219/255, green: 226/225, blue: 215/225, alpha: 1.0)
            l.fontName = "AmericanTypewriter-Bold"
            l.fontSize = 30
            l.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 60))
            addChild(l)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "back" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        }
    }

}
