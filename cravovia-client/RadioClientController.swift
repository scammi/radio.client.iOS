//
//  RadioClientController.swift
//  cravovia-client
//
//  Created by SantiCammi on 03/08/2021.
//

import Foundation
import AVFoundation
import MediaPlayer

var player: AVPlayer?
var playing = false

struct RadioClient {
    
    func play() {
        if !playing
        {
            NSLog("playing")
            
            let urlCracovia = URL(string: "https://tolkien.republicahosting.net:1614/live")
            let playerItem:AVPlayerItem = AVPlayerItem(url: urlCracovia!)
            player = AVPlayer(playerItem: playerItem)
            playing = true
            
            var nowPlayingInfo = [String: Any]()
            
            nowPlayingInfo[MPNowPlayingInfoPropertyAssetURL] = urlCracovia
            nowPlayingInfo[MPMediaItemPropertyTitle] = "titulo"
            nowPlayingInfo[MPMediaItemPropertyArtist] = "artista"
            nowPlayingInfo[MPMediaItemPropertyAlbumArtist] = "album artist"
            nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = "album title"
            
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            
        }
        player?.play()
    }
    
    func pause() {
        NSLog("pause")
        player?.pause()
        playing = false
    }
}
