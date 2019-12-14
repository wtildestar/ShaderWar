//
//  MenuScene.swift
//  ShaderWar
//
//  Created by wtildestar on 11/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
        Assets.shared.preloadAssets()
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        let texture = SKTexture(imageNamed: "playButton")
        let button = SKSpriteNode(texture: texture)
        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        button.name = "runButton"
        self.addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        // получаю объект под той областью на которую нажал
        let node = self.atPoint(location)
        
        if node.name == "runButton" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            // создаю сцену на которую перехожу
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
    }
}
