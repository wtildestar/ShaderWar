//
//  Background.swift
//  ShaderWar
//
//  Created by wtildestar on 02/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
    
    static func populateBackground(at point: CGPoint) -> Background {
        let background = Background(imageNamed: "background")
        background.position = point
        background.zPosition = 0
        
        return background
    }
    
}
