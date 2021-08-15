//
//  ContentView.swift
//  cravovia-client
//
//  Created by SantiCammi on 03/08/2021.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @ObservedObject var radioClient = RadioClient()
    
    var body: some View {
        VStack {
            Text("\(radioClient.currentlyPlaying)").padding()
        }
        HStack {
            Button(action: {
                radioClient.play()
            }) {
                 Image(systemName: "play").font(.title)
            }
            Button(action:  {
                radioClient.pause()
            }) {
                Image(systemName: "pause")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
