//
//  PlaybackFullscreenView.swift
//  MusicPlayer
//
//  Created by Pawan Dixit on 4/27/21.
//

import SwiftUI

struct PlaybackFullscreenView: View {
    
    var animation: Namespace.ID
    
    @EnvironmentObject var model: MusicManager
    
    @State var disclosureExpanded = false
    @State var playlistSheetPresented = false
    
    @State var isRepeat = false
    
    var body: some View {
        if let currentSong = model.currentSong {
            
            let artwork = model.uiImage
                
                VStack {
                    
                    Image(uiImage: artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .matchedGeometryEffect(id: (currentSong.title ?? "") + "art", in: animation)
                        .padding()
                        .padding(.top, 40)
                        .scaleEffect(model.isPlaying ? 1.0 : 0.5)
                        .shadow(color: Color.black.opacity(model.isPlaying ? 0.2 : 0.0), radius: 30, x: 0, y: 60)
                        .onTapGesture {
                            Haptics.hit()
                        }
                    
                    
                    Menu {
                        Button(action: {
                            playlistSheetPresented.toggle()
                        }, label: {
                            Text("Add to Playlist")
                        })
                    } label: {
                        VStack(spacing: 8) {
                            Text(currentSong.title ?? "NA")
                                .foregroundColor(.white)
                                .font(Font.system(.title2).bold())
                            
                            Text(currentSong.artist ?? "NA")
                                .foregroundColor(.white.opacity(0.5))
                                .foregroundColor(.secondary)
                                .font(Font.system(.title3).bold())
                            
                            Text("Tap to add to Library/Playlist")
                                .font(.caption2)
                        }
                        .matchedGeometryEffect(id: (currentSong.title ?? "") + "details", in: animation, properties: .position)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                    
                    Spacer(minLength: 0)
                    
                    ProgessView()
                        .padding(.horizontal)
                    
                    Spacer(minLength: 0)
                    
                    VStack {
                        HStack(spacing: 0) {
                            Image(systemName: "repeat")
                                .font(.largeTitle)
                                .font(.system(size: 45))
                                .multilineTextAlignment(.center)
                                .foregroundColor(isRepeat ? .blue : .white)
                                .onTapGesture {
                                    if isRepeat {
                                        model.musicPlayer.repeatMode = .none
                                    } else {
                                        model.musicPlayer.repeatMode = .one
                                    }
                                    isRepeat.toggle()
                                }
                            
                            Image(systemName: "gobackward.15")
                                .font(.largeTitle)
                                .font(.system(size: 45))
                                .padding(.leading, 30)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    model.musicPlayer.currentPlaybackTime -= 15
                                }
                            
                            PlayPauseButton()
                                .environmentObject(model)
                                .matchedGeometryEffect(id: (currentSong.title ?? "") + "play_button", in: animation)
                                .font(.system(size: 50))
                                .padding(.horizontal, 30)
                                .multilineTextAlignment(.center)
                            
                            Image(systemName: "goforward.15")
                                .font(.largeTitle)
                                .font(.system(size: 45))
                                .padding(.trailing, 30)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    model.musicPlayer.currentPlaybackTime += 15
                                }
                            
                            Image(systemName: "stop.fill")
                                .font(.largeTitle)
                                .font(.system(size: 45))
                                .onTapGesture {
                                    model.musicPlayer.skipToBeginning()
                                    model.musicPlayer.stop()
                                }
                            
                            
                        }
                        
                        AirplayView()
                            .frame(width: 50, height: 50)
                        
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 40)

                Spacer(minLength: 0)
            }
            .padding()
            .background(
                withAnimation(.easeOut) {
                    Rectangle()
                        .foregroundColor(Color(artwork.averageColor ?? .gray))
                        .saturation(0.5)
                        .matchedGeometryEffect(id: (currentSong.title ?? "") + "frame", in: animation)
                }
                
            )
            .accentColor(Color(artwork.originalAverageColor ?? .systemPink))
            .onAppear {
                hideKeyboard()
            }
        }
    }
}

