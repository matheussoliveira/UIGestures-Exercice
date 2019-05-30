//
//  BackgroundMusic.swift
//  EntregaGestures
//
//  Created by Matheus Oliveira on 29/05/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation
import AVFoundation

class BackgroundMusic {
    static let shared = BackgroundMusic()
    var audioPlayer: AVAudioPlayer?
    
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "bensound-slowmotion", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1  // Infinity loop
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopMusicBackground() {
        if let bundle = Bundle.main.path(forResource: "bensound-slowmotion", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.stop()
            } catch {
                print(error)
            }
        }
}
}
