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
    
    var soundFlag = 0   // Let us know if sound is enable or not
    var musicPlayer = AVAudioPlayer()
    var player: AVAudioPlayer?
    var stop: Bool = false  // Helps us with sun rotation contitions

    @IBOutlet weak var speaker: UIImageView!
    @IBOutlet weak var sun: UIImageView!
    @IBOutlet weak var birds: UIImageView!
    @IBOutlet weak var cloud: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var airplane: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        // Sets airplane off the screen
        airplane.center.x = -60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Defining background image programmatically
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "nathalia-barbosa-paisagem-comass.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        backgroundImage.isUserInteractionEnabled = true
        
        // Background music
        BackgroundMusic.shared.startBackgroundMusic()
        
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
        
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        rightSwipe.direction = .right
        backgroundImage.addGestureRecognizer(rightSwipe)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cloudAnimation()
    }
    
    // Background music stops on speaker tap
    @objc func tapHandler(_ tap: UITapGestureRecognizer) {
        if soundFlag == 0 {
            speaker.image = UIImage(named: "no-sound.png")!
            soundFlag = 1
            BackgroundMusic.shared.stopMusicBackground()
        } else {
            speaker.image = UIImage(named: "sound.png")!
            soundFlag = 0
            BackgroundMusic.shared.startBackgroundMusic()
        }
    }
    
    // Plays birds sound on double tap
    @objc func doubleTapHandler(_ tap: UITapGestureRecognizer) {
        BirdsEffects.shared.startBirdsSound()
    }
    
    // Clouds pan gesture
    @IBAction func panHandler(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {view.center = CGPoint(x:view.center.x +
                                                             translation.x,
                                                             y:view.center.y +
                                                             translation.y)}
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    // Clouds pinch gesture
    @IBAction func pinchHandler(recognizer : UIPinchGestureRecognizer) {
        
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    
    }
    
    // Clouds rotate gesture
    @IBAction func rotateHandler(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    // Sun rotation animation
    func rotate() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true,
                                 block: { (timer) in
            if self.stop {
                timer.invalidate()
            } else {
                self.sun.transform = self.sun.transform.rotated(by: .pi / 180)
            }
        })
    }
    
    // Sun long press gesture
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            // Start rotation
            self.stop = false
            rotate()
        }
        if sender.state == .ended {
            // Stop rotation
            self.stop = true
        }
    }
    
    // Swipe right gesture and airplane animation
    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            UIImageView.animate(withDuration: 5) {
                self.airplane.center.x += 700
                self.airplane.center.y -= 400
            }
        }
    }
    
    // Cloud animation
    func cloudAnimation() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true,
                                 block: { (timer) in
                                    UIImageView.animate(withDuration: 0.07) {
                                        self.cloud.center.x += 2
                                        self.cloud2.center.x += 2
                                        self.cloud3.center.x += 2
                                    }
        })
    }
}

// Extends our ViewController to let us
// move clouds while using pinch gesture
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
