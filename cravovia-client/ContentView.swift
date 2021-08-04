//
//  ContentView.swift
//  cravovia-client
//
//  Created by SantiCammi on 03/08/2021.
//

import SwiftUI
import AVFoundation


struct ContentView: View {
    var radioClient = RadioClient()
    
    var body: some View {
        HStack {
            Button("PLAY ", action:  {
                radioClient.play()
            })
            Button("STOP ", action:  {
                radioClient.pause()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
