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
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Spacer()

                    Image("cracovia")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250.0, height: 250.0, alignment: .center)
                        .clipShape(Circle())
                    
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

                }.navigationTitle("Radio Cracovia").navigationBarHidden(false)

            }.foregroundColor(.white)
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
