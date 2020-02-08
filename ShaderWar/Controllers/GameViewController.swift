//
//  GameViewController.swift
//  ShaderWar
//
//  Created by wtildestar on 02/12/2019.
//  Copyright © 2019 wtildestar. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let scene = MenuScene(size: self.view.bounds.size)
            
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            
            view.showsNodeCount = true

        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        super.viewWillTransition(to: size, with: coordinator)

        guard
            let skView = self.view as? SKView,
            let canReceiveRotationEvents = skView.scene as? CanReceiveTransitionEvents else { return }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, windowScene.activationState == .foregroundActive, let _ = windowScene.windows.first else { return }

        switch windowScene.interfaceOrientation {
        case .unknown:
            print("unknown")

        case .portrait:
            print("portrait")

        case .portraitUpsideDown:
            print("portraitUpsideDown")

        case .landscapeLeft:
            print("landscapeLeft")

        case .landscapeRight:
            print("landscapeRight")

        @unknown default:
            print("default")
        }
        canReceiveRotationEvents.viewWillTransition(to: size)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
