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
    
    static func popupate(at point: CGPoint) -> PlayerPlane {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(2)
        playerPlane.position = point
        playerPlane.zPosition = 20
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
        planeAnimationFillArray()
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
    
    fileprivate func planeAnimationFillArray() {
        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {
            self.leftTextureArrayAnimation = {
                var array = [SKTexture]()
                for i in stride(from: 1, through: 2, by: -1) {
                    let number = String(format: "%02d", i)
                    let texture = SKTexture(imageNamed: "plane_\(number)")
                    array.append(texture)
                }
                // return array нельзя выполнить в .preload тк completionHandler исполняется не в основном потоке
                SKTexture.preload(array) {
                    print("Preload is done")
                }
                return array
            }()
            
            self.rightTextureArrayAnimation = {
                var array = [SKTexture]()
                for i in stride(from: 2, through: 3, by: 1) {
                    let number = String(format: "%02d", i)
                    let texture = SKTexture(imageNamed: "plane_\(number)")
                    array.append(texture)
                }
                
                SKTexture.preload(array) {
                    print("Preload is done")
                }
                return array
            }()
            self.forwardTextureArrayAnimation = {
                var array = [SKTexture]()
                    let texture = SKTexture(imageNamed: "plane_01")
                    array.append(texture)
                
                SKTexture.preload(array) {
                    print("Preload is done")
                }
                return array
            }()
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
