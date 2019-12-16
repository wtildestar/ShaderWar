//
//  MissileRed.swift
//  ShaderWar
//
//  Created by wtildestar on 09/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class MissileRed: Missile {
    init() {
        let textureAtlas = Assets.shared.missileRedAtlas
        super.init(textureAtlas: textureAtlas)
        name = "missileRed"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
