//
//  FileManagerHelper.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import Foundation

class FileManagerHelper {
    static let shared = FileManagerHelper()
    private init() {}

    private let fileName = "CS50.json"

    private var _fileURL: URL? {
        guard let supportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return nil }
        let folder = supportDir.appendingPathComponent("HarvardCS50X")
        if !FileManager.default.fileExists(atPath: folder.path) {
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        }
        return folder.appendingPathComponent(fileName)
    }

    // ✅ Public access to fileURL
    var fileURL: URL? {
        return _fileURL
    }

    var profileImagePath: URL {
        guard let supportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Unable to get Application Support directory")
        }
        let folder = supportDir.appendingPathComponent("HarvardCS50X")
        return folder.appendingPathComponent("profile.png")
    }

    func saveAppData(_ data: AppData) {
        guard let url = fileURL else { return }
        do {
            let encoded = try JSONEncoder().encode(data)
            try encoded.write(to: url)
        } catch {
            print("❌ Failed to save app data:", error)
        }
    }

    func loadAppData() -> AppData? {
        guard let url = fileURL else { return nil }
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(AppData.self, from: data)
        } catch {
            print("❌ Failed to load app data:", error)
            return nil
        }
    }

    func createInitialAppDataIfNeeded() {
        if loadAppData() == nil {
            let newAppData = AppData(
                userName: nil,
                startDate: nil,
                studyWeeks: 12,
                paused: false,
                pausedAt: nil,
                urls: []
            )
            saveAppData(newAppData)
        }
    }
}

