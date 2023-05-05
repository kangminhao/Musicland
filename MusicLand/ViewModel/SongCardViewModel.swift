//
//  SongCardViewModel.swift
//  MusicLand
//
//  Created by 康明浩 on 2023/5/5.
//

import Foundation
import MediaPlayer
import SDWebImageSwiftUI

class SongCardViewModel: ObservableObject {
    let song: MPMediaItem
    @Published var title = "NA"
    @Published var artist = "NA"
    @Published var coverImage = UIImage(named: "music_background") ?? UIImage()
    //var manager: ImageManager?
    @Published var choosePlaylistOptionsPresented = false
    
    init(song: MPMediaItem) {
        self.song = song
        title = song.title ?? "NA"
        artist = song.artist ?? "NA"
    }
    
    func play() {
        DispatchQueue.main.async { [self] in
            let desc = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items: [song]))
            MusicManager.shared.musicPlayer.setQueue(with: desc)
            MusicManager.shared.musicPlayer.play()
        }
    }
    
    func loadImage() {
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            if let image = (song.artwork?.image(at: CGSize(width: 140, height: 140))) {
                coverImage = image
            }
        }
    }
    
    func addToQueue() {
        MusicManager.shared.musicPlayer.perform(queueTransaction: { [self] queue in

          let afterItem = queue.items.last
            let desc = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items: [song]))
            
          return queue.insert(desc, after: afterItem)

        }) { (queue, error) in
          // Completion for when items' position update
          if let error = error {
            print(error)
          }
        }
    }
    
    
}
