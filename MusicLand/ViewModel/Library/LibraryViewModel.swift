//
//  LibraryViewModel.swift
//  MusicLand
//
//  Created by 康明浩 on 2023/5/4.
//

import Foundation
import MediaPlayer

final class LibraryViewModel: ObservableObject {
    @Published var librarySongs: [MPMediaItem] = []
    
    init() {
        
    }
    
}
