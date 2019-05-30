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
    
    func startBirdsSound() {
        if let bundle = Bundle.main.path(forResource: "birds-sound", ofType: "aiff") {
            let birdsSound = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:birdsSound as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
}
