//
//  NowPlayingView.swift
//  Jinx
//
//  Created by Pawan Dixit on 4/28/21.
//

import SwiftUI

struct NowPlayingView: View {
    
    @Namespace var animation
    
    @EnvironmentObject var model: Model
    
    @GestureState var gestureState = CGSize.zero
    @State var gestureStore = CGSize.zero
    
    var body: some View {
        
        Group {
            if model.isPlayerViewPresented {
                PlaybackFullscreenView(animation: animation)
                    .environmentObject(model)
                    .offset(CGSize(width: gestureState.width + gestureStore.width, height: gestureState.height + gestureStore.height))
                    .edgesIgnoringSafeArea(.all)
                
            } else {
                PlaybackbarView(animation: animation)
                    .environmentObject(model)
                    .onTapGesture {
                        gestureStore.height = 0
                        withAnimation(Animation.spring(response: 0.7, dampingFraction: 0.85)) {
                            Haptics.softRoll()
                            model.isPlayerViewPresented.toggle()
                        }
                    }
                    .padding(.bottom, 48)
            }
            
        }
        .simultaneousGesture(DragGesture().updating($gestureState, body: { value, state, transaction in
            if value.translation.height > 0 {
                state.height = value.translation.height
            }
        })
        .onEnded({ value in
            let translationheight = max(value.translation.height, value.predictedEndTranslation.height * 0.2)
            
            if translationheight > 0 {
                gestureStore.height = translationheight
                
                if translationheight > 50 {
                    withAnimation(Animation.spring(response: 0.7, dampingFraction: 0.85)) {
                        model.isPlayerViewPresented = false
                    }
                } else {
                    withAnimation(Animation.spring(response: 0.7, dampingFraction: 0.85)) {
                        gestureStore.height = 0
                    }
                    
                }
            }
            
        }))
    }
}
