//
//  MenuScene.swift
//  ShaderWar
//
//  Created by wtildestar on 11/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class MenuScene: ParentScene {
    override func didMove(to view: SKView) {
        if !Assets.shared.isLoaded {
            Assets.shared.preloadAssets()
            Assets.shared.isLoaded = true
        }
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        setHeader(withName: nil, andBackground: "paused")
        let header = SKSpriteNode(imageNamed: "paused")
//        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
//        header.setScale(0.2)
//        self.addChild(header)
        
        let titles = ["play", "options", "best"]
        
        for (index, title) in titles.enumerated() {
            let button1 = ButtonNode(titled: title, backgroundName: "buttonBackground")
            button1.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button1.name = title
            button1.label.name = title
            button1.setScale(0.1)
            addChild(button1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        // получаю объект под той областью на которую нажал
        let node = self.atPoint(location)
        
        if node.name == "play" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            // создаю сцену на которую перехожу
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
        else if node.name == "options" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let optionsScene = OptionsScene(size: self.size)
            // наша сцена будет обратной сценой для optionsScene
            optionsScene.backScene = self
            // создаю сцену на которую перехожу
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
        }
    }
}
