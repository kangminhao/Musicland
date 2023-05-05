//
//  SongCardView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/24/21.
//

import SwiftUI
import MediaPlayer

struct SongCardView: View {
    let viewModel: SongCardViewModel
                
    var body: some View {
        
        HStack {
            Image(uiImage: viewModel.coverImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.headline)
                Text(viewModel.artist)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.play()
            }, label: {
                Image(systemName: "play.fill")
                    .font(.title)
                    .opacity(0.0001)
            })
        }
        .onAppear() {
            viewModel.loadImage()
        }
        .contextMenu {
            
            Button(action: {
                viewModel.choosePlaylistOptionsPresented.toggle()
            }, label: {
                Text("Add to Playlist")
            })

            Button(action: {
                viewModel.addToQueue()
            }, label: {
                Text("Add to queue")
            })
        }
    }
}
