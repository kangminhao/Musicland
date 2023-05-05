//
//  SearchView.swift
//  MusicLand
//
//  Created by 康明浩 on 2022/12/14.
//

import SwiftUI
import Combine

struct SearchView: View {
    @Binding var isTyping: Bool
    @StateObject var viewModel = SearchViewModel()
                
    var body: some View {
        
        VStack {
            
            TextField("Search Songs", text: $viewModel.searchText, onEditingChanged: { isEditing in
                
                isTyping = isEditing ? true : false
                
            }, onCommit: {
                UIApplication.shared.resignFirstResponder()
                
                viewModel.searchSongs()
            })
            .submitLabel(.search)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 16)
            .onReceive(Just(viewModel.searchText)) { searchText in
                viewModel.searchSongs()
            }
            
            List {
                ForEach(viewModel.searchResults, id:\.self) { song in
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
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
            }
    }
}
