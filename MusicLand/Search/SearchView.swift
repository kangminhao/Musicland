//
//  SearchView.swift
//  MusicLand
//
//  Created by 康明浩 on 2022/12/14.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var model: Model
    
    @State var searchText = ""
    @State var searchResults = [Song]()
    
    var body: some View {
        
        VStack {
            TextField("Search Songs", text: $searchText, onCommit: {
                UIApplication.shared.resignFirstResponder()
                
                if searchText.isEmpty {
                    searchResults = [Song]()
                } else {
                    // API call
                    DispatchQueue.global(qos: .userInitiated).async {
                        searchResults = AppleMusicAPI.shared.search(query: searchText)
                    }
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 16)
            
            List {
                ForEach(searchResults, id:\.self) { song in
                    RemoteSongCardView(song: song)
                }
            }
        }
        .padding(.vertical)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
