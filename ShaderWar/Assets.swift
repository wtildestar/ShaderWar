//
//  Assets.swift
//  ShaderWar
//
//  Created by wtildestar on 11/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

// Подгружаем класс singleton в appdelegate
class Assets {
    static let shared = Assets()
    let flameAtlas = SKTextureAtlas(named: "Flame")
    let missileRedAtlas = SKTextureAtlas(named: "MissileRed")
    let missileGreenAtlas = SKTextureAtlas(named: "MissileGreen")
    let bomb_2Atlas = SKTextureAtlas(named: "Bomb_2")
    let bomb_3Atlas = SKTextureAtlas(named: "Bomb_3")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    
    func preloadAssets() {
        flameAtlas.preload{ print("flameAtlas preloaded") }
        missileRedAtlas.preload{ print("missileRedAtlas preloaded") }
        missileGreenAtlas.preload{ print("missileGreenAtlas preloaded") }
        bomb_2Atlas.preload{ print("bomb_2Atlas preloaded") }
        bomb_3Atlas.preload{ print("bomb_3Atlas preloaded") }
        playerPlaneAtlas.preload{ print("playerPlaneAtlas preloaded") }
    }
}
