//
//  ParentScene.swift
//  ShaderWar
//
//  Created by wtildestar on 15/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class ParentScene: SKScene {
    let sceneManager = SceneManager.shared
    var backScene: SKScene?
    
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        let header = ButtonNode(titled: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        header.setScale(0.1)
        self.addChild(header)
    }
}
