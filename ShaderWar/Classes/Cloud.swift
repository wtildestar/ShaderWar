//
//  Cloud.swift
//  ShaderWar
//
//  Created by wtildestar on 02/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    
    static func populate(at point: CGPoint?) -> Cloud {
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = randomPoint()
        cloud.zPosition = 10
        cloud.name = "sprite"
        cloud.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        cloud.run(move(from: cloud.position))
        return cloud
    }
    
    fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNumber = distribution.nextInt()
        let imageName = "cl" + "\(randomNumber)"
        
        return imageName
    }
    
    fileprivate static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 10, highestValue: 50)
        let randomNumber = CGFloat(distribution.nextInt()) / 4 // генерируем новое значение Int / 10
        
        return randomNumber
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 150.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
    
}
