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
    var streaming = "https://tolkien.republicahosting.net:1614/live"
    
    func play() {
        if !playing
        {
            NSLog("playing")
            
            // Create playerItem
            let urlCracovia = URL(string: streaming)
            let playerItem: AVPlayerItem = AVPlayerItem(url: urlCracovia!)
            
            // Metadata output processing
            let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
            metadataOutput.setDelegate(self, queue: DispatchQueue.main)
            playerItem.add(metadataOutput)
            
            // Create palyer
            player = AVPlayer(playerItem: playerItem)
            
            // Display palying info
            let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
            var nowPlayingInfo = [String: Any]()
            
            let image = UIImage(named: "cracovia")!
            let mediaArtwork = MPMediaItemArtwork(boundsSize: image.size) { (size: CGSize) -> UIImage in
              return image
            }
            
            nowPlayingInfo[MPNowPlayingInfoPropertyAssetURL] = streaming
            nowPlayingInfo[MPNowPlayingInfoPropertyMediaType] = "stream"
            nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
            nowPlayingInfo[MPMediaItemPropertyTitle] = "Radio Cracovia"
            nowPlayingInfo[MPMediaItemPropertyArtist] = "artist"
            nowPlayingInfo[MPMediaItemPropertyArtwork] = mediaArtwork
            nowPlayingInfo[MPMediaItemPropertyAlbumArtist] = "albumartist"
            nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = "albumtitle"
            
            nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
            nowPlayingInfoCenter.playbackState = .playing
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                
                try AVAudioSession.sharedInstance().setActive(true)
                
               } catch(let error) {
                   print(error.localizedDescription)
               }
            
            print("Now playing lock screen: \(String(describing: MPNowPlayingInfoCenter.default().nowPlayingInfo))")
            setupNowPlayingInfoCenter()
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
    
    func setupNowPlayingInfoCenter(){
        UIApplication.shared.beginReceivingRemoteControlEvents()
        MPRemoteCommandCenter.shared().playCommand.addTarget {event in
          self.play()
          return .success
        }
        MPRemoteCommandCenter.shared().pauseCommand.addTarget {event in
          self.pause()
          return .success
        }
      }
}
