//
//  ContentView.swift
//  cravovia-client
//
//  Created by SantiCammi on 03/08/2021.
//

import SwiftUI
import AVFoundation

var player: AVPlayer?

struct ContentView: View {
    var radioClient = RadioClient()
    
    var body: some View {
        HStack {
            Button("PLAY ", action:  {
                NSLog("playing")
                let urlCracovia = URL(string: "https://tolkien.republicahosting.net:1614/live")
                let playerItem:AVPlayerItem = AVPlayerItem(url: urlCracovia!)
                player = AVPlayer(playerItem: playerItem)
                player?.play()
            })
            Button("STOP ", action:  {
                NSLog("stop")
                player?.pause()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
