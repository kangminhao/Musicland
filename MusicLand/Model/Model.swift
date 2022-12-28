//
//  Model.swift
//  MusicLand
//
//  Created by 康明浩 on 2022/12/9.
//

import Foundation
import MediaPlayer

class Model: ObservableObject {
    
    static let shared = Model()
    
    var musicPlayer = MPMusicPlayerController.applicationQueuePlayer
    
    @Published var currentSong: MPMediaItem?
    @Published var isPlayerViewPresented = false
    
    @Published var playlists = [MPMediaItemCollection]()
    @Published var librarySongs = [MPMediaItem]()
    
    @Published var isPlaying = false
    
    @Published var uiImage = UIImage()
    
    @Published var queuedSongs = [MPMediaItem]()
    
    @Published var isTyping = false
}
