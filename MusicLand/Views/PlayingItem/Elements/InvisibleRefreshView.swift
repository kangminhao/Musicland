//
//  InvisibleRefreshView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/27/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MediaPlayer

struct InvisibleRefreshView: View {
    let viewModel = InvisibleRefreshViewModel()
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { _ in
                viewModel.refreshSongs()
            }
    }
}

struct InvisibleRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        InvisibleRefreshView()
    }
}
