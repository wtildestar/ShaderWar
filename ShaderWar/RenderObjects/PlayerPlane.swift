//
//  PlayerPlane.swift
//  ShaderWar
//
//  Created by wtildestar on 03/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    var moveDirection: TurnDirection = .none
    var stillTurning = false
    let animationSpriteStrides = [(1, 2, -1), (2, 3, 1), (1, 1, 1)]
    
    static func popupate(at point: CGPoint) -> PlayerPlane {
        let atlas = Assets.shared.playerPlaneAtlas
        let playerPlaneTexture = atlas.textureNamed("plane_0")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(2)
        playerPlane.position = point
        playerPlane.zPosition = 40
        
        // оффсеты
        let offsetX = playerPlane.frame.size.width * playerPlane.anchorPoint.x
        let offsetY = playerPlane.frame.size.height * playerPlane.anchorPoint.y
        
        // траектория
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 2 - offsetX, y: 27 - offsetY))
        path.addLine(to: CGPoint(x: 11 - offsetX, y: 27 - offsetY))
        path.addLine(to: CGPoint(x: 14 - offsetX, y: 33 - offsetY))
        path.addLine(to: CGPoint(x: 29 - offsetX, y: 34 - offsetY))
        path.addLine(to: CGPoint(x: 31 - offsetX, y: 27 - offsetY))
        path.addLine(to: CGPoint(x: 41 - offsetX, y: 24 - offsetY))
        path.addLine(to: CGPoint(x: 43 - offsetX, y: 23 - offsetY))
        path.addLine(to: CGPoint(x: 41 - offsetX, y: 16 - offsetY))
        path.addLine(to: CGPoint(x: 25 - offsetX, y: 14 - offsetY))
        path.addLine(to: CGPoint(x: 25 - offsetX, y: 7 - offsetY))
        path.addLine(to: CGPoint(x: 30 - offsetX, y: 4 - offsetY))
        path.addLine(to: CGPoint(x: 30 - offsetX, y: 0 - offsetY))
        path.addLine(to: CGPoint(x: 12 - offsetX, y: 0 - offsetY))
        path.addLine(to: CGPoint(x: 13 - offsetX, y: 4 - offsetY))
        path.addLine(to: CGPoint(x: 17 - offsetX, y: 6 - offsetY))
        path.addLine(to: CGPoint(x: 17 - offsetX, y: 14 - offsetY))
        path.addLine(to: CGPoint(x: 3 - offsetX, y: 15 - offsetY))
        path.addLine(to: CGPoint(x: 0 - offsetX, y: 17 - offsetY))
        path.addLine(to: CGPoint(x: 0 - offsetX, y: 24 - offsetY))
        path.closeSubpath()
        playerPlane.physicsBody = SKPhysicsBody(polygonFrom: path)
        
//        playerPlane.physicsBody = SKPhysicsBody(texture: playerPlaneTexture, alphaThreshold: 0.5, size: playerPlane.size)
        playerPlane.physicsBody?.isDynamic = false // задаю false динамичности тела при столкновении фиксированное
        playerPlane.physicsBody?.categoryBitMask = BitMaskCategory.player
        playerPlane.physicsBody?.collisionBitMask = BitMaskCategory.enemy | BitMaskCategory.missile // задаю вражескую битовую маску для столкновения
        playerPlane.physicsBody?.contactTestBitMask = BitMaskCategory.enemy | BitMaskCategory.missile // фиксирую столкновения
        return playerPlane
    }
    
    func checkPosition() {
        self.position.x += xAcceleration * 50
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performFly() {
//        planeAnimationFillArray()
        preloadTextureArrays()
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
                
            }
        }
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionCheckAction = SKAction.run { [unowned self] in
            self.movementDirectionCheck()
        }
        
        let planeSequence = SKAction.sequence([planeWaitAction, planeDirectionCheckAction])
        let planceSequenceForever = SKAction.repeatForever(planeSequence)
        self.run(planceSequenceForever)
        
    }
    
    
    fileprivate func preloadArray(_stride: (Int, Int, Int), callback: @escaping (_ array: [SKTexture]) -> ()) {
        var array = [SKTexture]()
        for i in stride(from: _stride.0, through: _stride.1, by: _stride.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "plane_\(number)")
            array.append(texture)
        }
        SKTexture.preload(array) {
            callback(array)
        }
    }
    
    fileprivate func preloadTextureArrays() {
        for i in 0...2 {
            self.preloadArray(_stride: animationSpriteStrides[i]) { [unowned self] array in
                switch i {
                case 0:
                    self.leftTextureArrayAnimation = array
                case 1:
                    self.rightTextureArrayAnimation = array
                case 2:
                    self.forwardTextureArrayAnimation = array
                default:
                    break
                }
            }
        }
    }
    
    fileprivate func movementDirectionCheck() {
        if xAcceleration > 0.02, moveDirection != .right, stillTurning == false {
            stillTurning = true
            moveDirection = .right
            turnPlane(direction: .right)
        } else if xAcceleration < -0.02, moveDirection != .left, stillTurning == false {
            stillTurning = true
            moveDirection = .left
            turnPlane(direction: .left)
        } else if stillTurning == false {
            
        }
    }
    
    fileprivate func turnPlane(direction: TurnDirection) {
        var array = [SKTexture]()
        
        if direction == .right {
            array = rightTextureArrayAnimation
        } else if direction == .left {
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        self.run(sequenceAction) { [unowned self] in
            self.stillTurning = false
        }
    }
}

enum TurnDirection {
    case left
    case right
    case none
}
