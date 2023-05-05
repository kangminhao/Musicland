//
//  MusicManager.swift
//  MusicLand
//
//  Created by 康明浩 on 2023/5/4.
//

import Foundation
import MediaPlayer

class MusicManager: ObservableObject {
    
    static let shared = MusicManager()
    
    var musicPlayer = MPMusicPlayerController.applicationQueuePlayer
    
    @Published var currentSong: MPMediaItem?
    @Published var isPlayerViewPresented = false
        
    @Published var isPlaying = false
    
    @Published var uiImage = UIImage()
    
    @Published var queuedSongs = [MPMediaItem]()
    
    @Published var isTyping = false
}
