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
                    Image("cracovia")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250.0, height: 250.0, alignment: .center)
                        .clipShape(Circle())
                    
                    Text("\(radioClient.currentlyPlaying)").padding()
                    
                    Button(action: {
                        radioClient.play()
                    }) {
                        if (radioClient.playing)
                        {
                            Image(systemName: "pause").resizable()
                                .frame(width: 30.0, height: 30.0)
                        }
                        else
                        {
                            Image(systemName: "play").resizable()
                                .frame(width: 30.0, height: 30.0)
                        }
                    }.onAppear(perform: setUp).offset(y:100)
                                                   
                }.navigationTitle("Radio Cracovia").navigationBarHidden(false).navigationBarItems(
                    trailing:
                        Button(action: {
                            if let url = URL(string: "https://www.instagram.com/radiocracovia/") {
                                UIApplication.shared.open(url)}
                        }, label: {
                            Image("instagram").resizable()
                                .frame(width: 35.0, height: 35.0)
                        })
                )

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
