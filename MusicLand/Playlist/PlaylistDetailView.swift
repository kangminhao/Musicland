//
//  PlaylistDetailView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/27/21.
//

import SwiftUI
import MediaPlayer

struct PlaylistDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var model: Model
    
    let playlist: MPMediaItemCollection
    
    var body: some View {
        List {
            HStack {
                Spacer(minLength: 0)
                
                VStack {
                    Image(uiImage: (playlist.representativeItem?.artwork?.image(at: CGSize(width: 500, height: 500)) ?? UIImage(named: "music_background")) ?? UIImage())
                        .resizable()
                        .frame(width: 300, height: 300)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 30)
                    
                    VStack {
                        Text("\(playlist.value(forProperty: MPMediaPlaylistPropertyName) as? String ?? "NA")")
                            .bold()
                            .font(.title2)
                        
                        HStack {
                            HStack {
                                Spacer(minLength: 0)
                                Image(systemName: "play.fill")
                                Text("Play")
                                Spacer(minLength: 0)
                            }
                            .foregroundColor(.accentColor)
                            .padding(10)
                            .background(BlurView(style: .systemUltraThinMaterialDark).opacity(colorScheme == .light ? 0.3 : 0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                let desc = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items: playlist.items))
                                
                                model.musicPlayer.setQueue(with: desc)
                                model.musicPlayer.play()
                            }
                            
                            HStack {
                                Spacer(minLength: 0)
                                Image(systemName: "shuffle")
                                Text("Shuffle")
                                Spacer(minLength: 0)
                            }
                            .foregroundColor(.accentColor)
                            .padding(10)
                            .background(BlurView(style: .systemUltraThinMaterialDark).opacity(colorScheme == .light ? 0.3 : 0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                let desc = MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items: playlist.items.shuffled()))
                                
                                model.musicPlayer.setQueue(with: desc)
                                model.musicPlayer.play()
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                }
                Spacer(minLength: 0)
            }
            .padding()
            
            Section(header: HStack {
                Image(systemName: "music.note")
                Text("Songs in the playlist")
                    .font(.caption)
                Spacer()
            }.padding(.vertical, 5)) {
                ForEach(playlist.items, id:\.self) { song in
                    VStack(spacing: 0) {
                        SongCardView(song: song)
                            .environmentObject(model)
                    }
                }
                
                Rectangle()
                    .frame(height: 100)
                    .foregroundColor(.clear)
            }
            
        }
        .accentColor(.pink)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("\(playlist.items.count) Songs")
            }
        }
    }
}
