//
//  BirdsEffect.swift
//  EntregaGestures
//
//  Created by Matheus Oliveira on 30/05/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import AVFoundation

class BirdsEffects {
    static let shared = BirdsEffects()
    var audioPlayer: AVAudioPlayer?
    
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "birds-sound", ofType: "aiff") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = 0  // Infinity loop
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopMusicBackground() {
        if let bundle = Bundle.main.path(forResource: "birds-sound", ofType: "aiff") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = 0  // Infinity loop
                audioPlayer.prepareToPlay()
                audioPlayer.stop()
            } catch {
                print(error)
            }
        }
    }
}
