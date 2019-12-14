//
//  HUD.swift
//  ShaderWar
//
//  Created by wtildestar on 14/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class HUD: SKNode {
    let scoreBackground = SKSpriteNode(imageNamed: "score1")
    let scoreLabel = SKLabelNode(text: "10000")
    let menuButton = SKSpriteNode(imageNamed: "settings1")
    let life1 = SKSpriteNode(imageNamed: "life1")
    let life2 = SKSpriteNode(imageNamed: "life1")
    let life3 = SKSpriteNode(imageNamed: "life1")
    
    func configureUI(screenSize: CGSize) {
        scoreBackground.position = CGPoint(x: scoreBackground.size.width + 10, y: screenSize.height - scoreBackground.size.height / 2 - 10)
        scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        scoreBackground.zPosition = 99
        addChild(scoreBackground)
        
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -10, y: 3)
        scoreLabel.zPosition = 100
        
        scoreLabel.fontName = "AmeracanTypewriter-Bold"
        scoreLabel.fontSize = 30
        scoreBackground.addChild(scoreLabel)
        
        menuButton.position = CGPoint(x: 20, y: 20)
        menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        menuButton.zPosition = 100
        menuButton.name = "pause"
        addChild(menuButton)
        
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            life.setScale(0.3)
            life.position = CGPoint(x: screenSize.width - CGFloat(index + 1) * (life.size.width + 3), y: 20)
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            addChild(life)
        }
    }
}
