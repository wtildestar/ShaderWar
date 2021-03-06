//
//  GameScene.swift
//  ShaderWar
//
//  Created by wtildestar on 02/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: ParentScene {
    
    var backgroundMusic: SKAudioNode!
    
    fileprivate var player: PlayerPlane!
    fileprivate let hud = HUD()
    fileprivate let screenSize = UIScreen.main.bounds.size
    fileprivate var lives = 3 {
        didSet {
            switch lives {
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 2:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = true
            case 1:
                hud.life1.isHidden = false
                hud.life2.isHidden = true
                hud.life3.isHidden = true
            default:
                break
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        gameSettings.loadGameSetting()
        
        if gameSettings.isMusic && backgroundMusic == nil {
            if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") {
                backgroundMusic = SKAudioNode(url: musicURL)
                addChild(backgroundMusic)
            }
        }
        
        // Снимаем паузу
        self.scene?.isPaused = false
        
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
        
        enumerateChildNodes(withName: "missileGreen") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "missileRed") { (node, stop) in
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
            let transition = SKTransition.fade(withDuration: 0.4) //crossFade(withDuration: 1.0)
            // создаю сцену на которую перехожу
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            // сохраняем состояние в менеджер
            sceneManager.gameScene = self
            self.scene?.isPaused = true
            self.scene!.view?.presentScene(pauseScene, transition: transition)
        } else {
            playerFire()
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    // автоматически регистрирует столкновения
    func didBegin(_ contact: SKPhysicsContact) {
        
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
        // получаю точку соприкосновения для отрисовки взрыва
        let contactPoint = contact.contactPoint
        explosion?.position = contactPoint
        explosion?.zPosition = 25
        let waitForExplosionAction = SKAction.wait(forDuration: 1.0)
        
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
        case [.enemy, .player]: print("Enemy vs Player")
        if contact.bodyA.node?.name == "sprite" {
            if contact.bodyA.node?.parent != nil {
                contact.bodyA.node?.removeFromParent()
                lives -= 1
            }
        } else {
            if contact.bodyB.node?.parent != nil {
                contact.bodyB.node?.removeFromParent()
                lives -= 1
            }
        }
        addChild(explosion!)
        self.run(waitForExplosionAction) { explosion?.removeFromParent() }
        
        if lives == 0 {
            
            gameSettings.currentScore = hud.score
            gameSettings.saveScores()
            
            let gameOverScene = GameOverScene(size: self.size)
            gameOverScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 0.4)
            self.scene!.view?.presentScene(gameOverScene, transition: transition)
        }
            
        case [.missile, .player]: print("Missile vs Player")
        
        if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
            if contact.bodyA.node?.name == "missileGreen" {
                contact.bodyA.node?.removeFromParent()
                lives = 3
                player.missileGreen()
            } else if contact.bodyB.node?.name == "missileGreen" {
                contact.bodyA.node?.removeFromParent()
                lives = 3
                player.missileGreen()
            }
            
            if contact.bodyA.node?.name == "missileRed" {
                contact.bodyA.node?.removeFromParent()
                player.missileRed()
            } else {
                contact.bodyB.node?.removeFromParent()
                player.missileRed()
            }
        }
            
        case [.enemy, .shot]: print("Enemy vs Shot")
        
        if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            if gameSettings.isSound {
                self.run(SKAction.playSoundFileNamed("Fire", waitForCompletion: false))
            }
            
            hud.score += 5
            addChild(explosion!)
            self.run(waitForExplosionAction) { explosion?.removeFromParent() }
        }
            
            
        default: preconditionFailure("Unable to detect collision category")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
