//
//  InvisibleRefreshViewModel.swift
//  MusicLand
//
//  Created by 康明浩 on 2023/5/4.
//

import Foundation

class InvisibleRefreshViewModel: ObservableObject {
    
    init () {
        
    }
    
    func refreshSongs() {
        MusicManager.shared.musicPlayer.perform(queueTransaction: { queue in

            if MusicManager.shared.queuedSongs.count != queue.items.count {
                MusicManager.shared.queuedSongs.removeAll()
                MusicManager.shared.queuedSongs.append(contentsOf: queue.items)
            }

        }) { (queue, error) in
            if let error = error {
                print(error)
            }
        }
        
        if MusicManager.shared.currentSong?.playbackStoreID != MusicManager.shared.musicPlayer.nowPlayingItem?.playbackStoreID {
            MusicManager.shared.currentSong = MusicManager.shared.musicPlayer.nowPlayingItem
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let image = MusicManager.shared.musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 100, height: 100)) {
                    DispatchQueue.main.async {
                        MusicManager.shared.uiImage = image
                    }
                }
                
                if let image = MusicManager.shared.musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 800, height: 800)) {
                    DispatchQueue.main.async {
                        MusicManager.shared.uiImage = image
                    }
                }
            }
        }
    }
    
}
