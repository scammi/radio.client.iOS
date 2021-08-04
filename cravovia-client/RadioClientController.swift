//
//  RadioClientController.swift
//  cravovia-client
//
//  Created by SantiCammi on 03/08/2021.
//

import Foundation
import AVFoundation

struct RadioClient {
    var player: AVPlayer?
    
    func print() {
        NSLog("hello");
    }
    
    func play() {
        NSLog("playing")
    }
}
