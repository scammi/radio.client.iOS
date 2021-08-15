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

class RadioClient: NSObject, AVPlayerItemMetadataOutputPushDelegate, ObservableObject {
    
    @Published var currentlyPlaying: String = " "
    @Published var playing = false
    
    var startedListening = false

    func play() {
        if !playing
        {
            NSLog("playing")
            
            // Create playerItem
            let urlCracovia = URL(string: "https://tolkien.republicahosting.net:1614/live")
            let playerItem: AVPlayerItem = AVPlayerItem(url: urlCracovia!)
            
            // Metadata output processing
            let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
            metadataOutput.setDelegate(self, queue: DispatchQueue.main)
            playerItem.add(metadataOutput)
            
            // Create palyer
            player = AVPlayer(playerItem: playerItem)
            
            // Display palying info
            var nowPlayingInfo = [String: Any]()
            
            nowPlayingInfo[MPNowPlayingInfoPropertyAssetURL] = urlCracovia
            nowPlayingInfo[MPMediaItemPropertyTitle] = "titulo"
            nowPlayingInfo[MPMediaItemPropertyArtist] = "artista"
            nowPlayingInfo[MPMediaItemPropertyAlbumArtist] = "album artist"
            nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = "album title"
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
               } catch(let error) {
                   print(error.localizedDescription)
               }
            
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            startedListening = true
        }
        player?.play()
        playing = true
    }
    
    func pause() {
        NSLog("pause")
        player?.pause()
        playing = false
    }
    
    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {
        if let item = groups.first?.items.first // make this an AVMetadata item
        {
            self.currentlyPlaying = String(describing: item.value(forKeyPath: "value")!)
            NSLog("Now Playing: \n \(self.currentlyPlaying)") // print the results
        } else {
            NSLog("MetaData Error") // No Metadata or Could not read
        }
    }
}
