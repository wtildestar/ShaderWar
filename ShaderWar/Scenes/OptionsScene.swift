//
//  OptionsScene.swift
//  ShaderWar
//
//  Created by wtildestar on 15/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class OptionsScene: ParentScene {
    
    var isMusic: Bool!
    var isSound: Bool!
    
    override func didMove(to view: SKView) {
        
        isMusic = gameSettings.isMusic
        isSound = gameSettings.isSound
        
        setHeader(withName: "options", andBackground: "buttonBackground")
        
        let backgroundNameForMusic = isMusic == true ? "music" : "nomusic"
        let musicBtn = ButtonNode(titled: nil, backgroundName: backgroundNameForMusic)
        musicBtn.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        musicBtn.name = "music"
        musicBtn.label.isHidden = true
        musicBtn.setScale(0.2)
        addChild(musicBtn)
        
        let backgroundNameForSound = isSound == true ? "sound" : "nosound"
        let soundBtn = ButtonNode(titled: nil, backgroundName: backgroundNameForSound)
        soundBtn.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        soundBtn.name = "sound"
        soundBtn.label.isHidden = true
        soundBtn.setScale(0.2)
        addChild(soundBtn)
        
        let back = ButtonNode(titled: "back", backgroundName: "buttonBackground")
        back.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        back.name = "back"
        back.label.name = "back"
        back.setScale(0.2)
        addChild(back)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        // получаю объект под той областью на которую нажал
        let node = self.atPoint(location)
        
        if node.name == "music" {
            isMusic = !isMusic
            update(node: node as! SKSpriteNode, property: isMusic)
            
        } else if node.name == "sound" {
            isSound = !isSound
            update(node: node as! SKSpriteNode, property: isSound)
            
        } else if node.name == "back" {
            
            gameSettings.isSound = isSound
            gameSettings.isMusic = isMusic
            gameSettings.saveGameSettings()
            
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else { return }
            // создаю сцену на которую перехожу
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        }
    }
    
    func update(node: SKSpriteNode, property: Bool) {
        if let name = node.name {
            node.texture = property ? SKTexture(imageNamed: name) : SKTexture(imageNamed: "no" + name)
        }
    }
}
