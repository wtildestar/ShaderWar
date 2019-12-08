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
        self.name = "sprite"
    }
    
    func flySpiral() {
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 1
        let timeVertical: Double = 15
        let moveLeft = SKAction.moveTo(x: 60, duration: timeHorizontal) // граница допустимая до края экрана тк 450 ширина texture / 2 / 2 ~ 110
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 45, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        let asideMovementSequence = SKAction.sequence([moveLeft, moveRight])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        let forwardMovement = SKAction.moveTo(y: -150, duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
