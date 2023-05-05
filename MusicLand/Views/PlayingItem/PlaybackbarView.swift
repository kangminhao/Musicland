//
//  PlaybackbarView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/27/21.
//

import SwiftUI
import MediaPlayer

struct PlaybackbarView: View {
    
    var animation: Namespace.ID
    
    @EnvironmentObject var model: MusicManager
    
    @State var choosePlaylistOptionsPresented = false
    
    var body: some View {
        if let currentSong = model.currentSong {
            
            let artwork = model.uiImage
            
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                
                HStack(spacing: 0) {
                    Image(uiImage: artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .matchedGeometryEffect(id: (currentSong.title ?? "") + "art", in: animation)
                        .frame(width: 70, height: 70)
                        .padding(10)
                    
                    VStack(alignment: .leading) {
                        Text(currentSong.title ?? "NA")
                            
                            .font(.headline)
                            
                        Text(currentSong.artist ?? "NA")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .matchedGeometryEffect(id: (currentSong.title ?? "") + "details", in: animation, properties: .position)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 0) {
                        PlayPauseButton()
                            .environmentObject(model)
                            .matchedGeometryEffect(id: (currentSong.title ?? "") + "play_button", in: animation)
                            .font(.largeTitle)
                            
                        if model.queuedSongs.count > 1 {
                            Image(systemName: "forward.fill")
                                .font(.largeTitle)
                                .padding(.trailing, 5)
                                .background(Color.white.opacity(0.0001))
                                .onTapGesture(count: 2, perform: {
                                    model.musicPlayer.skipToPreviousItem()
                                })
                                .onTapGesture {
                                    model.musicPlayer.skipToNextItem()
                                }
                        }
                        
                    }
                    .padding(.trailing)
                }
                .background(
                    withAnimation(.easeOut) {
                        BlurView(style: .systemChromeMaterial)
                            .matchedGeometryEffect(id: (currentSong.title ?? "") + "frame", in: animation)
                    }
                    
                )
                .contextMenu {
                    Button(action: {
                        choosePlaylistOptionsPresented.toggle()
                    }, label: {
                        Text("Add to Playlist")
                    })
                }
            }
        }
    }
}
