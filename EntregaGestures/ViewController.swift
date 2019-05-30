//
//  ViewController.swift
//  EntregaGestures
//
//  Created by Matheus Oliveira on 28/05/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit
import CoreGraphics
import AVFoundation

class ViewController: UIViewController {
    
    var soundFlag = 0
    var musicPlayer = AVAudioPlayer()
    var player: AVAudioPlayer?

    @IBOutlet weak var speaker: UIImageView!
    
    @IBOutlet weak var sun: UIImageView!
    
    @IBOutlet weak var birds: UIImageView!
    @IBOutlet weak var cloud: Cloud!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: (UIImage(named: "nathalia-barbosa-paisagem-comass.png") ?? nil)!)
        
        // Defining background image programmatically
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "nathalia-barbosa-paisagem-comass.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Background music
        MusicPlayer.shared.startBackgroundMusic()
        
        // Long press button
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        sun.addGestureRecognizer(longPressGesture)
        
        // Birds tap
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapHandler(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        birds.addGestureRecognizer(doubleTap)
        
        // Sound tap
        speaker.image = UIImage(named: "sound.png")!
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler(_:)))
        speaker.addGestureRecognizer(tap)
    }
    
    // Background music stops on speaker tap
    @objc func tapHandler(_ tap: UITapGestureRecognizer) {
        if soundFlag == 0 {
            speaker.image = UIImage(named: "no-sound.png")!
            soundFlag = 1
            MusicPlayer.shared.stopMusicBackground()
        } else {
            speaker.image = UIImage(named: "sound.png")!
            soundFlag = 0
            MusicPlayer.shared.startBackgroundMusic()
        }
    }
    
    // Plays birds sound on double tap
    @objc func doubleTapHandler(_ tap: UITapGestureRecognizer) {
        // Play birds sound
        BirdsEffects.shared.startBackgroundMusic()
    }
    
    @IBAction func panHandler(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {view.center = CGPoint(x:view.center.x +
                                                             translation.x,
                                                             y:view.center.y +
                                                             translation.y)}
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func pinchHandler(recognizer : UIPinchGestureRecognizer) {
        
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    
    }
    
    @IBAction func rotateHandler(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "birds-sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    var stop: Bool = false
    
    func rotate() {
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true
            , block: { (timer) in
                
                if self.stop {
                    timer.invalidate()
                } else {
                    
                    self.sun.transform = self.sun.transform.rotated(by: .pi / 180)
                }
                
        })
    }
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            // start rotation
            self.stop = false
            rotate()
        }
        if sender.state == .ended {
            // stop rotation
            self.stop = true
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
