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
           
        setHeader(withName: nil, andBackground: "paused")
        //        let header = SKSpriteNode(imageNamed: "paused")
        //        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        //        header.setScale(0.2)
        //        self.addChild(header)
        
        let titles = ["play", "options", "score"]
        
        for (index, title) in titles.enumerated() {
            let button1 = ButtonNode(titled: title, backgroundName: "buttonBackground")
            button1.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button1.name = title
            button1.label.name = title
            button1.setScale(0.2)
            addChild(button1)
        }
    }
    
    var supportedInterfaceOrientations: UIInterfaceOrientationMask {
           
                   
        return .landscape
           
   }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        // получаю объект под той областью на которую нажал
        let node = self.atPoint(location)
        
        if node.name == "play" {
            let transition = SKTransition.crossFade(withDuration: 0.4)
            // создаю сцену на которую перехожу
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
        else if node.name == "options" {
            let transition = SKTransition.crossFade(withDuration: 0.4)
            let optionsScene = OptionsScene(size: self.size)
            // наша сцена будет обратной сценой для optionsScene
            optionsScene.backScene = self
            // создаю сцену на которую перехожу
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
        }
        else if node.name == "score" {
            let transition = SKTransition.crossFade(withDuration: 0.4)
            let bestScene = ScoreScene(size: self.size)
            // наша сцена будет обратной сценой для optionsScene
            bestScene.backScene = self
            // создаю сцену на которую перехожу
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        }
    }
}
