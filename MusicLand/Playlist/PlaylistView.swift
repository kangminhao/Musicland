//
//  PlaylistView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/23/21.
//

import SwiftUI

struct PlaylistView: View {
    
    @EnvironmentObject var model: Model

    var body: some View {
        NavigationView {
            
            ScrollView {
                
                HStack {
                    Image(systemName: "music.note")
                        .font(.subheadline)
                    Text("Your Playlists")
                        .font(.caption)

                    Spacer()
                }
                
                .foregroundColor(.accentColor)
                .padding(.horizontal)
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)], spacing: 15) {
                    
                    ForEach(model.playlists, id:\.self) { playlist in
                        
                        VStack(spacing: 0) {
                            NavigationLink(
                                destination: PlaylistDetailView(playlist: playlist),
                                label: {
                                    PlaylistCardView(playlist: playlist)
                                        .drawingGroup()
                                })
                        }
                    }
                }
                .padding(.horizontal, 15)
                
                Rectangle()
                    .frame(height: 100)
                    .foregroundColor(.clear)
            }
            .navigationBarTitle(Text("Playlists"), displayMode: .automatic)
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}
