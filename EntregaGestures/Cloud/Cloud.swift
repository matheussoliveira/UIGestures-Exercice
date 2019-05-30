//
//  Clouds.swift
//  EntregaGestures
//
//  Created by Matheus Oliveira on 30/05/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import Foundation

class Cloud {
    
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
    
}
