//
//  Shot.swift
//  ShaderWar
//
//  Created by wtildestar on 10/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class Flame: SKSpriteNode {
    let screenSize = UIScreen.main.bounds
    
    fileprivate let initialSize = CGSize(width: 256, height: 256)
    fileprivate let textureAtlas: SKTextureAtlas!
    fileprivate var textureNameBeginsWith = ""
    fileprivate var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        // берем универсальное имя текстуры в сортированном атлас
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        textureNameBeginsWith = String(textureName.dropLast(6)) // откидываем последние 6 символов наименования текстуры
        super.init(texture: texture, color: .clear, size: initialSize)
        self.name = "flameSprite"
        self.setScale(-0.36)
        self.zPosition = 30
    }
    
    func startMovement() {
        performRotation()
        // задаем напавление
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2)
        // запускаем SKAction
        self.run(moveForward)
    }
    
    fileprivate func performRotation() {
        for i in 1...9 {
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeginsWith + number.description))
        }
        
        SKTexture.preload(animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
