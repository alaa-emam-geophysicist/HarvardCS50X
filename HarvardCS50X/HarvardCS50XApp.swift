//
//  HarvardCS50XApp.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import SwiftUI


@main
struct HarvardCS50XApp: App {
    
    init() {
        FileManagerHelper.shared.createInitialAppDataIfNeeded()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.titleBar) // No native window controls
        .defaultSize(width: 600, height: 500)

    }
}

#Preview {
    ContentView()
}
