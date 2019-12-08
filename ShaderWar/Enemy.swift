//
//  Enemy.swift
//  ShaderWar
//
//  Created by wtildestar on 08/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    static var textureAtlas: SKTextureAtlas?
    
    init() {
        let texture = Enemy.textureAtlas?.textureNamed("Bomb_3_Idle_000")
        super.init(texture: texture, color: .clear, size: CGSize(width: 450, height: 300))
        self.xScale = -0.2
        self.yScale = -0.2
        self.zPosition = 20
        self.name = "enemySprite"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
