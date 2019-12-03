//
//  PlayerPlane.swift
//  ShaderWar
//
//  Created by wtildestar on 03/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

class PlayerPlane: SKSpriteNode {
    static func popupate(at point: CGPoint) -> SKSpriteNode {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane")
        let playerPlane = SKSpriteNode(texture: playerPlaneTexture)
        playerPlane.setScale(2)
        playerPlane.position = point
        playerPlane.zPosition = 20
        return playerPlane
    }
}
