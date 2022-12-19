//
//  AirplayView.swift
//  Jinx
//
//  Created by Pawan Dixit on 5/1/21.
//

import SwiftUI
import AVKit

struct AirplayView: View {
    var body: some View {
        AirPlayView()
    }
}

struct AirplayView_Previews: PreviewProvider {
    static var previews: some View {
        AirplayView()
    }
}

struct AirPlayView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {

        let routePickerView = AVRoutePickerView()
        routePickerView.backgroundColor = UIColor.clear
        routePickerView.activeTintColor = UIColor.red
        routePickerView.tintColor = UIColor.white

        return routePickerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
