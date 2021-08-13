//
//  ContentView.swift
//  cravovia-client
//
//  Created by SantiCammi on 03/08/2021.
//

import SwiftUI
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
         print(application.beginReceivingRemoteControlEvents())
         return true
    }
}

struct ContentView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
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
