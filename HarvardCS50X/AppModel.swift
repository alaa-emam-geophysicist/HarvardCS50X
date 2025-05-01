//
//  AppModel.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import Foundation
import SwiftUI

class AppModel: ObservableObject {
    static let shared = AppModel()

    @Published var appData: AppData {
        didSet {
            FileManagerHelper.shared.saveAppData(appData)
        }
    }

    @Published var profileImage: NSImage?

    private init() {
        self.appData = FileManagerHelper.shared.loadAppData() ?? AppData(
            userName: nil,
            startDate: nil,
            studyWeeks: 12,
            paused: false,
            pausedAt: nil,
            urls: []
        )

        loadProfileImage()
    }

    /// Load the user's profile image from disk (if available)
    func loadProfileImage() {
        let path = FileManagerHelper.shared.profileImagePath
        if FileManager.default.fileExists(atPath: path.path),
           let image = NSImage(contentsOf: path) {
            self.profileImage = image
        }
    }

    /// Save profile image to disk
    func saveProfileImage(_ image: NSImage) {
        if let data = image.tiffRepresentation,
           let bitmap = NSBitmapImageRep(data: data),
           let pngData = bitmap.representation(using: .png, properties: [:]) {
            try? pngData.write(to: FileManagerHelper.shared.profileImagePath)
            self.profileImage = image
        }
    }
}
