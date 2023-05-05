//
//  MainView.swift
//  MusicLand
//
//  Created by 康明浩 on 2023/5/4.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            InvisibleRefreshView()
                .opacity(0.0001)
            
            TabView(selection: $viewModel.selection) {
                PlaylistView(playlists: viewModel.playlists)
                    .tabItem {
                        VStack {
                            Image(systemName: "music.note.list")
                            Text("Playlists")
                        }
                    }
                    .tag(0)
                
                LibraryView(songs: viewModel.librarySongs)
                    .tabItem {
                        VStack {
                            Image(systemName: "music.note")
                            Text("Library")
                        }
                    }
                    .tag(1)
                
                SearchView(isTyping: $viewModel.isTyping)
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .tag(2)
                
            }
            .zIndex(1.0)
            
            NowPlayingView(isTyping: $viewModel.isTyping)
                .environmentObject(MusicManager.shared)
                .zIndex(2.0)
            
        }
        .accentColor(.pink)
        //        .onAppear() {
        //            DispatchQueue.global(qos: .userInitiated).async {
        //                _ = AppleMusicAPI.shared
        //            }
        //        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
