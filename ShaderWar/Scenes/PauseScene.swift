//
//  PauseScene.swift
//  ShaderWar
//
//  Created by wtildestar on 14/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class PauseScene: SKScene {
    
    let sceneManager = SceneManager.shared
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        let header = ButtonNode(titled: "pause", backgroundName: "buttonBackground")
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        header.setScale(0.2)
        self.addChild(header)
        
        let titles = ["restart", "options", "resume"]
        
        for (index, title) in titles.enumerated() {
            let button1 = ButtonNode(titled: title, backgroundName: "buttonBackground")
            button1.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button1.name = title
            button1.label.name = title
            button1.setScale(0.1)
            addChild(button1)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = sceneManager.gameScene {
            if !gameScene.isPaused {
                gameScene.isPaused = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        // получаю объект под той областью на которую нажал
        let node = self.atPoint(location)
        
        if node.name == "restart" {
            sceneManager.gameScene = nil
            let transition = SKTransition.crossFade(withDuration: 1.0)
            // создаю сцену на которую перехожу
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        } else if node.name == "resume" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let gameScene = sceneManager.gameScene else { return }
            // создаю сцену на которую перехожу
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
    }
}
