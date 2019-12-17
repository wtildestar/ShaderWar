//
//  GameSettings.swift
//  ShaderWar
//
//  Created by wtildestar on 17/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import UIKit

class GameSettings: NSObject {
    
    let ud = UserDefaults.standard
    
    var isMusic = true
    var isSound = true
    
    let musicKey = "music"
    let soundKey = "sound"
    
    var highscore: [Int] = []
    var currentScore = 0
    let highscoreKey = "highscore"
    
    override init() {
        super.init()
        
        loadGameSetting()
        loadScores()
    }
    
    func saveScores() {
        highscore.append(currentScore)
        highscore = Array(highscore.sorted { $0 > $1 }.prefix(3)) // $0 > $1 сортировка с конца, возвращаю массив упорядоченный по убыванию с 3 элементами
        ud.set(highscore, forKey: highscoreKey)
        ud.synchronize()
    }
    
    func loadScores() {
        // проверяем есть ли уже какой-либо массив хранящийся по данному ключу
        guard ud.value(forKey: highscoreKey) != nil else { return }
        highscore = ud.array(forKey: highscoreKey) as! [Int]
    }
    
    func saveGameSettings() {
        ud.set(isMusic, forKey: musicKey)
        ud.set(isSound, forKey: soundKey)
    }
    
    func loadGameSetting() {
        guard ud.value(forKey: musicKey) != nil && ud.value(forKey: soundKey) != nil else { return }
        isMusic = ud.bool(forKey: musicKey)
        isSound = ud.bool(forKey: soundKey)
    }
}
