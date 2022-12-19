//
//  MusicLandApp.swift
//  MusicLand
//
//  Created by 康明浩 on 2022/12/9.
//

import SwiftUI
import StoreKit
import MediaPlayer

@main
struct MusicLandApp: App {
    
    @Environment(\.scenePhase) var scenePhase

    init() {
        updateSongs()
    }
    
    @State var onActive = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase, perform: { value in
                    if value == .active {
                        updateSongs()
                    }
                })
        }
    }
    
    func updateSongs() {
        SKCloudServiceController.requestAuthorization { status in
            if status == .authorized {
                
                let songsQuery = MPMediaQuery.songs()
                if let songs = songsQuery.items {
                    let desc = NSSortDescriptor(key: MPMediaItemPropertyLastPlayedDate, ascending: false)
                    let sortedSongs = NSArray(array: songs).sortedArray(using: [desc])
                    Model.shared.librarySongs = sortedSongs as! [MPMediaItem]
                }
                let playlistQuery = MPMediaQuery.playlists()
                if let playlists = playlistQuery.collections {
                    
                    Model.shared.playlists = playlists
                }
            }
        }
    }
}
