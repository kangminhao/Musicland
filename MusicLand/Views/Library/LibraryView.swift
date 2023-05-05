//
//  LibraryView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/23/21.
//

import SwiftUI
import MediaPlayer

struct LibraryView: View {
    let songs: [MPMediaItem]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(songs, id:\.self) { song in
                    VStack(spacing: 0) {
                        SongCardView(viewModel: SongCardViewModel(song: song))
                    }
                    
                }
                
                Rectangle()
                    .frame(height: 100)
                    .foregroundColor(.clear)
            }
            .navigationBarTitle(Text("Library"), displayMode: .automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(songs.count) Songs")
                }
            }
        }
    }
}

//struct LibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryView()
//    }
//}
