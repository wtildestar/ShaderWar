//
//  MissileGreen.swift
//  ShaderWar
//
//  Created by wtildestar on 09/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class MissileGreen: Missile {
    init() {
        let textureAtlas = Assets.shared.missileGreenAtlas
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
