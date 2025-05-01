//
//  SettingsView.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var name: String
    @Environment(\.dismiss) var dismiss

    @State private var tempName: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("🔧 Settings")
                .font(.title2.bold())

            TextField("Your Name", text: $tempName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 280)

            Button("Save Changes") {
                name = tempName
                var currentData = FileManagerHelper.shared.loadAppData() ?? AppData(startDate: nil, studyWeeks: 12, paused: false, pausedAt: nil, urls: [])
                currentData.userName = name
                FileManagerHelper.shared.saveAppData(currentData)
                dismiss()
            }

            Button("Cancel") {
                dismiss()
            }
            .foregroundColor(.secondary)
        }
        .onAppear {
            tempName = name
        }
        .padding()
        .frame(width: 320, height: 200)
    }
}
