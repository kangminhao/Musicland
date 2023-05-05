//
//  PlayPauseButton.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/27/21.
//

import SwiftUI

struct PlayPauseButton: View {
    
    @EnvironmentObject var model: Model
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        Image(systemName: model.isPlaying ? "pause.fill" : "play.fill")
            .onReceive(timer, perform: { _ in
                let isPlaying = model.musicPlayer.playbackState == .playing
                if model.isPlaying != isPlaying {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                        model.isPlaying = isPlaying
                    }
                }
            })
            .padding()
            .background(Color.white.opacity(0.0001))
            .onTapGesture(count: 2, perform: {
                model.musicPlayer.skipToBeginning()
            })
            .onTapGesture {
                Haptics.hit(0.5)
                DispatchQueue.main.async {
                    if model.musicPlayer.playbackState == .paused || model.musicPlayer.playbackState == .stopped {
                        model.musicPlayer.play()
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            model.isPlaying = true
                        }
                    } else {
                        model.musicPlayer.pause()
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            model.isPlaying = false
                        }
                    }
                }
                
            }
    }
}

struct PlayPauseButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseButton()
    }
}
