//
//  ButtonNode.swift
//  ShaderWar
//
//  Created by wtildestar on 14/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
    let label: SKLabelNode = {
        let l = SKLabelNode(text: "")
        l.fontColor = UIColor(red: 219/255, green: 226/225, blue: 215/225, alpha: 1.0)
        l.fontName = "AmericanTypewriter-Bold"
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.zPosition = 2
        l.fontSize = 100
        return l
    }()
    
    init(titled title: String?, backgroundName: String) {
        let texture = SKTexture(imageNamed: backgroundName)
        super.init(texture: texture, color: .clear, size: texture.size())
        if let title = title {
            label.text = title.uppercased()
        }
//        label.fontSize = 30
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
