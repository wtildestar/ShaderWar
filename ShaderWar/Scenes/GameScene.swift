//
//  GameScene.swift
//  ShaderWar
//
//  Created by wtildestar on 02/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {

    let sceneManager = SceneManager.shared
    
    fileprivate var player: PlayerPlane!
    fileprivate let hud = HUD()
    fileprivate let screenSize = UIScreen.main.bounds.size
    
    override func didMove(to view: SKView) {
        
        // checking if scene persist
        guard sceneManager.gameScene == nil else { return }
        // сохраняем сцену
        sceneManager.gameScene = self
        
        // подписываюсь под протокол для регистрации столкновений
        physicsWorld.contactDelegate = self
        // приравниваю силу гравитации к нулю
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        spawnClouds()
        spawnIslands()
        self.player.performFly()
        
        spawnMissile()
        // делаем спаун врагов с задержкой 1сек и кол-вом
//        spawnEnemy(count: 5)
        spawnEnemies()
        createHUD()
    }
    
    fileprivate func createHUD() {
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
    }
    
    fileprivate func spawnMissile() {
        let spawnAction = SKAction.run {
            let randomNumber = Int(arc4random_uniform(2))
            let missile = randomNumber == 1 ? MissileRed() : MissileGreen()
            // зарождаемся на рандомной точке по оси x и 100 point за экраном по высоте
            let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
            missile.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
            missile.startMovement()
            self.addChild(missile)
        }
        
        let randomTimeSpawn = Double(arc4random_uniform(10) + 10)
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
        
    }
    
    fileprivate func spawnEnemies() {
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        // запускаем сам SKAction передав в нем еще один SKAction с двуми секвенциями
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    fileprivate func spawnSpiralOfEnemies() {
        let enemyTextureAtlas1 = Assets.shared.bomb_2Atlas
        let enemyTextureAtlas2 = Assets.shared.bomb_3Atlas
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
            
            let randomNumber = Int(arc4random_uniform(2))
            let arrayOfAtlasses = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlasses[randomNumber]
            
            // задаю задержку для отрисовки
            let waitAction = SKAction.wait(forDuration: 1.0)
            // запускаю textureAtlas Enemy
            let spawnEnemy = SKAction.run { [unowned self] in
                let textureNames = textureAtlas.textureNames.sorted()
                let texture = textureAtlas.textureNamed(textureNames[1]) // использую первый элемент массива (первое изобажение) .atlas из своих кадров
                let enemy = Enemy(enemyTexture: texture)
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 100)
                self.addChild(enemy)
                enemy.flySpiral()
            }
            // задаю последовательность действий
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: 3)
            self.run(repeatAction)
        }
        
    }
    
    fileprivate func spawnClouds() {
        let spawnCloudWait = SKAction.wait(forDuration: 1)
        let spawnCloudAction = SKAction.run {
            // создаем облако с рандомной точкой за пределами экрана наверху
            let cloud = Cloud.populate(at: nil)
            self.addChild(cloud)
        }
        
        // заносим два SKAction в последовательность
        let spawnCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        run(spawnCloudForever)
    }
    
    fileprivate func spawnIslands() {
        let spawnIslandWait = SKAction.wait(forDuration: 2)
        let spawnIslandAction = SKAction.run {
            // создаем облако с рандомной точкой за пределами экрана наверху
            let island = Island.populate(at: nil)
            self.addChild(island)
        }
        
        // заносим два SKAction в последовательность
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        run(spawnIslandForever)
    }
    
    fileprivate func configureStartScene() {
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds
        
        let island1 = Island.populate(at: CGPoint(x: 100, y: 200))
        self.addChild(island1)
        let island2 = Island.populate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(island2)
        
        player = PlayerPlane.popupate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
    }
    
    override func didSimulatePhysics() {
        
        player.checkPosition()
        
        enumerateChildNodes(withName: "sprite") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "flameSprite") { (node, stop) in
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent()
            }
        }
    }
    
    fileprivate func playerFire() {
        let flame = FireFlame()
        flame.position = self.player.position
        flame.startMovement()
        self.addChild(flame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        // получаю объект под той областью на которую нажал
        let node = self.atPoint(location)
        
        if node.name == "pause" {
            let transition = SKTransition.doorway(withDuration: 1.0) //crossFade(withDuration: 1.0)
            // создаю сцену на которую перехожу
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(pauseScene, transition: transition)
        } else {
            playerFire()
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    // автоматически регистрирует столкновения
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
        case [.enemy, .player]: print("Enemy vs Player")
        case [.missile, .player]: print("Missile vs Player")
        case [.enemy, .shot]: print("Enemy vs Shot")
        default: preconditionFailure("Unable to detect collision category")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
