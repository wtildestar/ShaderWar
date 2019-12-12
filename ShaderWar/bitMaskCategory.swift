//
//  bitMaskCategory.swift
//  ShaderWar
//
//  Created by wtildestar on 11/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit

extension SKPhysicsBody {
    var category: BitMaskCategory {
        get {
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
}

// присваиваю категории для создания побитовых масок
struct BitMaskCategory: OptionSet {
    let rawValue: UInt32
    
    static let none    = BitMaskCategory(rawValue: 0 << 0) // 0
    static let player  = BitMaskCategory(rawValue: 1 << 0) // 1
    static let enemy   = BitMaskCategory(rawValue: 1 << 1) // 2
    static let missile = BitMaskCategory(rawValue: 1 << 2) // 4
    static let shot    = BitMaskCategory(rawValue: 1 << 3) // 8
    static let all     = BitMaskCategory(rawValue: UInt32.max)
}
