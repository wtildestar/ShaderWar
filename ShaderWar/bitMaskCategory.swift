//
//  bitMaskCategory.swift
//  ShaderWar
//
//  Created by wtildestar on 11/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import Foundation

// присваиваю категории для создания побитовых масок
struct BitMaskCategory {
    static let player : UInt32 = 0x1 << 0 // 1
    static let enemy : UInt32 = 0x1 << 1 // 2
    static let missile : UInt32 = 0x1 << 2 // 4
    static let shot : UInt32 = 0x1 << 3 // 8
}
