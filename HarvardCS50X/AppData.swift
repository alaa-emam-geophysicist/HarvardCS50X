//
//  AppData.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import Foundation

struct URLItem: Codable, Identifiable {
    var id = UUID()
    var urlString: String
    var title: String?
    var domain: String?
    var comment: String?
}

struct AppData: Codable {
    var userName: String?
    var courseName: String? // ← add this line
    var startDate: Date?
    var studyWeeks: Int
    var paused: Bool
    var pausedAt: Date?
    var urls: [URLItem]

}
