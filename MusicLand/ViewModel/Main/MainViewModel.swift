//
//  MainViewModel.swift
//  MusicLand
//
//  Created by 康明浩 on 2023/5/4.
//

import Foundation
import StoreKit
import MediaPlayer

class MainViewModel: ObservableObject {
    @Published var selection = 0
    @Published var playlists: [MPMediaItemCollection] = []
    @Published var librarySongs: [MPMediaItem] = []
    @Published var isTyping = false
    
    init() {
        updateSongs()
    }
    
    func updateSongs() {
        SKCloudServiceController.requestAuthorization { status in
            if status == .authorized {
                let songsQuery = MPMediaQuery.songs()
                if let songs = songsQuery.items {
                    let desc = NSSortDescriptor(key: MPMediaItemPropertyLastPlayedDate, ascending: false)
                    let sortedSongs = NSArray(array: songs).sortedArray(using: [desc])
                    self.librarySongs = sortedSongs as! [MPMediaItem]
                }
                let playlistQuery = MPMediaQuery.playlists()
                if let playlists = playlistQuery.collections {
                    self.playlists = playlists
                    
                    print("playlists: ", playlists)
                }
            }
        }
    }

    
}
