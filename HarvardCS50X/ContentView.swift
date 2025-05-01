//
//  ContentView.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var model = AppModel.shared

    var body: some View {
        ZStack {
            // Full background effect
            VisualEffectView(material: .hudWindow, blendingMode: .behindWindow)
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)

            VStack(spacing: 1) {
                TopSectionView()
// DEPRECATED - Not in use anymore     Merged to topsectionview         CountdownView()
                URLInputView(urls: $model.appData.urls)
                URLListView()
            }
            .padding()
            .zIndex(1)

            // Optional greeting overlay
            GreetingView()
                .zIndex(2)

            // Window customization
            WindowAccessor { window in
                window.titlebarAppearsTransparent = true
                window.isOpaque = false
                window.backgroundColor = .clear
                window.isMovableByWindowBackground = true
                window.standardWindowButton(.closeButton)?.isHidden = false
                window.standardWindowButton(.miniaturizeButton)?.isHidden = false
                window.standardWindowButton(.zoomButton)?.isHidden = true
            }
        }
    }
}
//#Preview {
//    
//}
