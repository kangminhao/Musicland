//
//  ProgessView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/27/21.
//

import SwiftUI

struct ProgessView: View {
    
    @EnvironmentObject var model: Model
    
    @State private var downloadAmount = 0.0
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    @State private var isEditing: Bool = false

    
    var body: some View {
        if let currentSong = model.musicPlayer.nowPlayingItem {
            ProgressView("", value: downloadAmount, total: currentSong.playbackDuration)
                .onReceive(timer, perform: { _ in
                    downloadAmount = model.musicPlayer.currentPlaybackTime
                })
                .accentColor(.gray)
            
            HStack {
                Text(DateComponentsFormatter.positional.string(from: downloadAmount) ?? "0:00")
                
                Spacer()
                
                Text(DateComponentsFormatter.positional.string(from: currentSong.playbackDuration - downloadAmount) ?? "0:00")
            }
            .font(.caption)
            .foregroundColor(.white)
        }
        
    }
    
    
}

struct ProgessView_Previews: PreviewProvider {
    static var previews: some View {
        ProgessView()
    }
}
