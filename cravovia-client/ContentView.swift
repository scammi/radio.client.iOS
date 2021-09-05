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
        NavigationView {
            VStack {
                Spacer()

                Text("\(radioClient.currentlyPlaying)").padding()
                HStack {
                    Button(action: {
                        radioClient.play()
                    }) {
                        if (radioClient.playing)
                        {
                            Image(systemName: "pause").font(.title)
                        }
                        else
                        {
                            Image(systemName: "play").font(.title)
                        }
                            
                    }
                }.onAppear(perform: setUp)

            }.navigationTitle("Radio Cracovia")
        }
    }
    
    private func setUp(){
        return radioClient.setUp()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
