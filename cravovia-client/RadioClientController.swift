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

class RadioClient: NSObject, AVPlayerItemMetadataOutputPushDelegate {
    weak var myDelegate: AVPlayerItemMetadataOutputPushDelegate?
    
    func play() {
        if !playing
        {
            NSLog("playing")
            
            let urlCracovia = URL(string: "https://tolkien.republicahosting.net:1614/live")
            let playerItem: AVPlayerItem = AVPlayerItem(url: urlCracovia!)
            
            let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
            metadataOutput.setDelegate(self, queue: DispatchQueue.main)
            playerItem.add(metadataOutput)
            
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
    
    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {
        if let item = groups.first?.items.first // make this an AVMetadata item
        {
            item.value(forKeyPath: "value") // looking for that key bro
            let Song = (item.value(forKeyPath: "value")!)
             NSLog("Now Playing: \n \(Song)") // print the results
        } else {
            NSLog("MetaData Error") // No Metadata or Could not read
        }
    }
}
