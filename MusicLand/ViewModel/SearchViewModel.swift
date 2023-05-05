//
//  SearchViewModel.swift
//  MusicLand
//
//  Created by 康明浩 on 2023/5/4.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var isType: Bool = false
    @Published var searchText = ""
    @Published var searchResults: [Song] = []
    
    init() {
        
    }
    
    func searchSongs() {
        if searchText.isEmpty {
            searchResults = []
        } else {
            DispatchQueue.global(qos: .userInitiated).async {  [self] in
                searchResults = AppleMusicAPI.shared.search(query: searchText)
            }
        }
    }
    
}
