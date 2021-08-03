//
//  ContentView.swift
//  cravovia-client
//
//  Created by SantiCammi on 03/08/2021.
//

import SwiftUI

struct ContentView: View {
    let radioClient = RadioClient()
    
    var body: some View {
        Button("PLAY ", action:  {radioClient.print()})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
