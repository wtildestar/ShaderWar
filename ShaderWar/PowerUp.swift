//
//  PowerUp.swift
//  ShaderWar
//
//  Created by wtildestar on 05/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import UIKit
import SpriteKit

class PowerUp: SKSpriteNode {
    let initialSize = CGSize(width: 52, height: 52)
    let textureAtlas = SKTextureAtlas(named: "PowerUp")
    var animationSpriteArray = [SKTexture]()
    
    init() {
        let greenTexture = textureAtlas.textureNamed("Bomb_1_Idle_00")
        super.init(texture: greenTexture, color: .clear, size: initialSize)
        self.name = "powerUp"
        self.zPosition = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performRotation() {
        for i in 1...9 {
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: "Bomb_1_Idle_\(number)"))
        }
        
        SKTexture.preload(animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
}
