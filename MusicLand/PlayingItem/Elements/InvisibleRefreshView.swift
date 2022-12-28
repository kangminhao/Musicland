//
//  InvisibleRefreshView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/27/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MediaPlayer

struct InvisibleRefreshView: View {
    
    @EnvironmentObject var model: Model
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State var manager: ImageManager?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { _ in
                
                model.musicPlayer.perform(queueTransaction: { queue in

                    if model.queuedSongs.count != queue.items.count {
                        model.queuedSongs.removeAll()
                        model.queuedSongs.append(contentsOf:  queue.items)
                    }

                }) { (queue, error) in

                  if error != nil {
                    print(error!)
                  }
                }
                
                if model.currentSong?.playbackStoreID != model.musicPlayer.nowPlayingItem?.playbackStoreID {
                    model.currentSong = model.musicPlayer.nowPlayingItem
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        if let image = model.musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 100, height: 100)) {
                            DispatchQueue.main.async {
                                model.uiImage = image
                            }
                        }
                        
                        if let image = model.musicPlayer.nowPlayingItem?.artwork?.image(at: CGSize(width: 800, height: 800)) {
                            DispatchQueue.main.async {
                                model.uiImage = image
                            }
                        }
                    }
                }
            }
    }
}

struct InvisibleRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        InvisibleRefreshView()
    }
}
