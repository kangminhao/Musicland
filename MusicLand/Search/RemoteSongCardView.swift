//
//  SongCardView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/24/21.
//

import SwiftUI
import MediaPlayer
import SDWebImageSwiftUI

struct RemoteSongCardView: View {
    
    @EnvironmentObject var model: Model
    
    let song: Song
    
    @State var artwork: UIImage = UIImage(named: "music_background") ?? UIImage()
    @State var manager: ImageManager?
    
    @State var choosePlaylistOptionsPresented = false
    
    var body: some View {
        
        HStack {
            WebImage(url: URL(string: song.artworkUrl.replacingOccurrences(of: "{w}", with: "\(Int(70) * 2)").replacingOccurrences(of: "{h}", with: "\(Int(70) * 2)")))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(song.name ?? "NA")
                    .font(.headline)
                Text(song.artist ?? "NA")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                DispatchQueue.main.async {
                    model.musicPlayer.setQueue(with: [song.id])
                    model.musicPlayer.play()
                }
            }, label: {
                Image(systemName: "play.fill")
                    .font(.title)
                    .opacity(0.0001)
            })
        }
        .contextMenu {
            
            Button(action: {
                choosePlaylistOptionsPresented.toggle()
            }, label: {
                Text("Add to Playlist")
            })

            Button(action: {
                model.musicPlayer.perform(queueTransaction: { queue in

                  let afterItem = queue.items.last
                    let desc = MPMusicPlayerStoreQueueDescriptor(storeIDs: [song.id])

                  //return the modification here.
                  return queue.insert(desc, after: afterItem)

                }) { (queue, error) in

                  // Completion for when items' position update
                  if error != nil {
                    print(error!)
                  }
                }
            }, label: {
                Text("Add to queue")
            })
        }
    }
}
