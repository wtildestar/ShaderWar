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
    var enemyTexture: SKTexture!
    
    init(enemyTexture: SKTexture) {
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 450, height: 300))
        self.xScale = -0.2
        self.yScale = -0.2
        self.zPosition = 20
        self.name = "sprite"
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy
        self.physicsBody?.collisionBitMask = BitMaskCategory.player | BitMaskCategory.shot
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player | BitMaskCategory.shot
    }
    
    func flySpiral() {
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 3
        let timeVertical: Double = 5
        let moveLeft = SKAction.moveTo(x: 60, duration: timeHorizontal) // граница допустимая до края экрана тк 450 ширина texture / 2 / 2 ~ 110
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 45, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        
        let randomNumber = Int(arc4random_uniform(2)) // 0 и 1 возможные варианты
        let asideMovementSequence = randomNumber == EnemyDirection.left.rawValue ? SKAction.sequence([moveLeft, moveRight]) : SKAction.sequence([moveRight, moveLeft])
        
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        let forwardMovement = SKAction.moveTo(y: -150, duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum EnemyDirection: Int {
    case left = 0
    case right
}
