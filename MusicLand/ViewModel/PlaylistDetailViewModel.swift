//
//  PlaylistDetailViewModel.swift
//  MusicLand
//
//  Created by 康明浩 on 2023/5/5.
//

import Foundation
import MediaPlayer

class PlaylistDetailViewModel: ObservableObject {
    let playlist: MPMediaItemCollection
    @Published var coverImage = UIImage()
    @Published var playlistName = "NA"
    
    init(playlist: MPMediaItemCollection) {
        self.playlist = playlist
        self.coverImage = getCoverImage() ?? UIImage()
        self.playlistName = getPlayListName() ?? "NA"
    }
    
    func play() {
        let desc = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items: playlist.items))
        
        MusicManager.shared.musicPlayer.setQueue(with: desc)
        MusicManager.shared.musicPlayer.play()
    }
    
    func shuffle() {
        let desc = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items: playlist.items.shuffled()))
        
        MusicManager.shared.musicPlayer.setQueue(with: desc)
        MusicManager.shared.musicPlayer.play()
    }
    
    func getCoverImage() -> UIImage? {
        return playlist.representativeItem?.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "music_background")
    }
    
    func getPlayListName() -> String? {
        return "\(playlist.value(forProperty: MPMediaPlaylistPropertyName) as? String ?? "NA")"
    }
    
}
