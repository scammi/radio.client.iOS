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
    let urlCracovia = URL(string: "http://198.50.225.239:8010/live")
    
    func setUp() {
        // Create playerItem
        setAudioPriority()
        let playerItem: AVPlayerItem = AVPlayerItem(url: self.urlCracovia!)
        
        // Metadata output processing
        let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
        metadataOutput.setDelegate(self, queue: DispatchQueue.main)
        playerItem.add(metadataOutput)
        
        setMediaInformation(streamingURL: self.urlCracovia!, metadata: currentlyPlaying)

        // Create palyer
        player = AVPlayer(playerItem: playerItem)
    }
    
    func play() {
        setupNowPlayingInfoCenter()
        
        if(playing)
        {
            player?.pause()
            playing = false
        }
        else
        {
            player?.play()
            playing = true
        }
    }
    
    func pause() {
        player?.pause()
        playing = false
    }
    
    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {
        if let item = groups.first?.items.first // make this an AVMetadata item
        {
            // Parse metadata
            self.currentlyPlaying = Utils.parseMetaData(metadata: String(describing: item.value(forKeyPath: "value")!))

            setMediaInformation(streamingURL: self.urlCracovia!, metadata: currentlyPlaying)

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

func setMediaInformation(streamingURL: URL, metadata: String)
{
    // Display palying info
    let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    var nowPlayingInfo = [String: Any]()
    
    let image = UIImage(named: "cracovia")!
    let mediaArtwork = MPMediaItemArtwork(boundsSize: image.size) { (size: CGSize) -> UIImage in
      return image
    }
    
    // Get album metadata, query service
    AlbumCover.getId()
    
    nowPlayingInfo[MPNowPlayingInfoPropertyAssetURL] = streamingURL
    nowPlayingInfo[MPNowPlayingInfoPropertyMediaType] = "stream"
    nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
    nowPlayingInfo[MPMediaItemPropertyArtist] = metadata
    nowPlayingInfo[MPMediaItemPropertyArtwork] = mediaArtwork
    
    nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    nowPlayingInfoCenter.playbackState = .playing
}

func setAudioPriority()
{
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try AVAudioSession.sharedInstance().setActive(true)
        
       } catch(let error) {
           print(error.localizedDescription)
       }
}


