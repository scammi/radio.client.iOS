//
//  utils.swift
//  cravovia-client
//
//  Created by SantiCammi on 12/09/2021.
//

import Foundation

class Utils {
    static func parseMetaData(metadata: String!) -> String
    {
        let metadata = metadata.components(separatedBy: "-")
        
        let album = metadata[0]
        let song  = metadata[1]
        
        
        let cleanSong = cleanSong(song: song)
        
        var nowPlaying = ""
        
        if album == "Unknown"
        {
            nowPlaying = cleanSong
        }
        else
        {
            nowPlaying = "\(album) - \(cleanSong)"
        }
    
        
        print("PARSE METADATA >>>> album: \(album), song: \(song)")

        return nowPlaying
    }
    
    static func cleanSong(song name: String) -> String
    {
        let bracketIndex = name.firstIndex(of: "[")
        
        if (bracketIndex != nil)
        {
             return String(name[..<bracketIndex!])
        }
        else { return name }
    }
}
