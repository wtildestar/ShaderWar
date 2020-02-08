//
//  protocol GameBackgroundSpriteable + Extension.swift
//  ShaderWar
//
//  Created by wtildestar on 04/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpriteable {
    static func populate(at point: CGPoint?) -> Self // Self это тип протокола GameBackgroundSpriteable / тип класса Cloud
    static func randomPoint() -> CGPoint
}

protocol CanReceiveTransitionEvents {
    func viewWillTransition(to size: CGSize)
}

extension GameBackgroundSpriteable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height + 400), highestValue: Int(screen.size.height + 500))
        let y = CGFloat(distribution.nextInt()) // nextInt генерируем какое-нибудь значение
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width))) // здесь счет от 0 до upperBound - верхней границы
        return CGPoint(x: x, y: y)
    }
}
