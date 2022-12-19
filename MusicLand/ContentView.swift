//
//  ContentView.swift
//  MusicLand
//
//  Created by 康明浩 on 2022/12/9.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = Model.shared
    
    @State var selection = 0
    
    var body: some View {
        ZStack {
            
            InvisibleRefreshView()
                .environmentObject(model)
                .opacity(0.0001)
            
            TabView(selection: $selection) {
                PlaylistView()
                    .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "music.note.list")
                            Text("Playlists")
                        }
                    }
                    .tag(0)
                
                LibraryView()
                    .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "music.note")
                            Text("Library")
                        }
                    }
                    .tag(1)
                
                SearchView()
                    .environmentObject(model)
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .tag(2)
                
            }
            .zIndex(1.0)
            
            NowPlayingView()
                .environmentObject(model)
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
