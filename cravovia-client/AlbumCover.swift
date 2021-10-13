//
//  AlbumCover.swift
//  cravovia-client
//
//  Created by SantiCammi on 13/10/2021.
//

import Foundation

class AlbumCover {
    static func getAlbum() {
        
    }
    
    static func getId() {
        // Create URL        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "musicbrainz.org"
        components.path = "/ws/2/cdstub"
        components.queryItems = [
            URLQueryItem(name: "limit", value: "1"),
            URLQueryItem(name: "query", value: "title:dark side of the moon")
        ]
        
        guard let requestUrl = components.url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
            
        }
        task.resume()
    }
}
