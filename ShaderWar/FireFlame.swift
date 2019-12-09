//
//  FireFlame.swift
//  ShaderWar
//
//  Created by wtildestar on 10/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class FireFlame: Flame {
    init() {
        let textureAtlas = SKTextureAtlas(named: "Flame")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
