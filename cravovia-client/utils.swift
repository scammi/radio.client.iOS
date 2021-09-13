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
        var nowPlaying = ""
        
        if album == "Unknown"
        {
            nowPlaying = song
        }
        else
        {
            nowPlaying = "\(album) - \(song)"
        }
        
        
        print("PARSE METADATA >>>> album: \(album), song: \(song)")

        return nowPlaying
    }
}
