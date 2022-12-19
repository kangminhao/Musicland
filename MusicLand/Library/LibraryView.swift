//
//  LibraryView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/23/21.
//

import SwiftUI
import MediaPlayer

struct LibraryView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.librarySongs, id:\.self) { song in
                    VStack(spacing: 0) {
                        SongCardView(song: song)
                            .environmentObject(model)
                    }
                    
                }
                
                Rectangle()
                    .frame(height: 100)
                    .foregroundColor(.clear)
            }
            .navigationBarTitle(Text("Library"), displayMode: .automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(model.librarySongs.count) Songs")
                }
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
