//
//  ParentScene.swift
//  ShaderWar
//
//  Created by wtildestar on 15/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class ParentScene: SKScene, CanReceiveTransitionEvents {
    func viewWillTransition(to size: CGSize) {
        
    }
    
    let gameSettings = GameSettings()
    let sceneManager = SceneManager.shared
    var backScene: SKScene?
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        let header = ButtonNode(titled: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        header.setScale(0.2)
        self.addChild(header)
    }
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
