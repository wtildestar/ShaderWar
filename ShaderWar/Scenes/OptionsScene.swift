//
//  OptionsScene.swift
//  ShaderWar
//
//  Created by wtildestar on 15/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class OptionsScene: ParentScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        setHeader(withName: "options", andBackground: "buttonBackground")
        
        let musicBtn = ButtonNode(titled: nil, backgroundName: "music")
        musicBtn.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        musicBtn.name = "music"
        musicBtn.label.isHidden = true
        musicBtn.setScale(0.1)
        addChild(musicBtn)
        
        let soundBtn = ButtonNode(titled: nil, backgroundName: "music")
        soundBtn.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        soundBtn.name = "sound"
        soundBtn.label.isHidden = true
        soundBtn.setScale(0.1)
        addChild(soundBtn)
        
        let back = ButtonNode(titled: nil, backgroundName: "buttonBackground")
        back.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        back.name = "back"
        back.label.isHidden = true
        back.setScale(0.1)
        addChild(back)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        // получаю объект под той областью на которую нажал
        let node = self.atPoint(location)
        
        if node.name == "music" {
            print("music")
        } else if node.name == "sound" {
            print("sound")
        } else if node.name == "back" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else { return }
            // создаю сцену на которую перехожу
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        }
    }
}
