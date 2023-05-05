//
//  ContentView.swift
//  MusicLand
//
//  Created by 康明浩 on 2022/12/9.
//

import SwiftUI
import StoreKit
import MediaPlayer

struct ContentView: View {
        
    @Environment(\.scenePhase) var scenePhase

    @State var onActive = false

    var body: some View {
        MainView()
//            .onChange(of: scenePhase, perform: { value in
//                if value == .active {
//                    updateSongs()
//                }
//            })
    }
}


