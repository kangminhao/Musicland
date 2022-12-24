//
//  SearchView.swift
//  MusicLand
//
//  Created by 康明浩 on 2022/12/14.
//

import SwiftUI
import Combine

struct SearchView: View {
    @EnvironmentObject var model: Model
    
    @State var searchText = ""
    @State var searchResults: [Song] = []
    
    @State private var typing = false
        
    var body: some View {
        
        VStack {
            
            TextField("Search Songs", text: $searchText, onCommit: {
                UIApplication.shared.resignFirstResponder()
                
                if searchText.isEmpty {
                    searchResults = []
                } else {
                    DispatchQueue.global(qos: .userInitiated).async {
                        searchResults = AppleMusicAPI.shared.search(query: searchText)
                    }
                }
            })
            .submitLabel(.search)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 16)
            .onReceive(Just(searchText)) { searchText in
                if searchText.isEmpty {
                    searchResults = []
                } else {
                    DispatchQueue.global(qos: .userInitiated).async {
                        searchResults = AppleMusicAPI.shared.search(query: searchText)
                    }
                }
            }
            
            List {
                ForEach(searchResults, id:\.self) { song in
                    RemoteSongCardView(song: song)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ _ in
                        hideKeyboard()
                    })
            )
        
        }
        .padding(.vertical)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
