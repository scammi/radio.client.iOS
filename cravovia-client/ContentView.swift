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
    var radioClient = RadioClient()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
