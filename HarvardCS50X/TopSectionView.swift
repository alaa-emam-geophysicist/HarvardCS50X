//
//  TopSectionView.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

import SwiftUI

struct TopSectionView: View {
    @State private var name: String = "Your Name"
    @State private var showNamePrompt = false
    @State private var tempName: String = ""
    @State private var startDate: Date = Date()
    @State private var studyWeeks: Int = 12
    @State private var isAnimating = false
    @State private var now = Date()
    @State private var timer: Timer?

    private var countdownText: String {
        let totalDays = studyWeeks * 7
        let endDate = Calendar.current.date(byAdding: .day, value: totalDays, to: startDate) ?? Date()
        
        // Calculate the time difference between now and the endDate
        let interval = endDate.timeIntervalSince(now)
        
        // If interval is negative, it's overdue
        if interval < 0 {
            let absInterval = abs(interval)
            let days = Int(absInterval) / 86400
            let hours = (Int(absInterval) % 86400) / 3600
            let minutes = (Int(absInterval) % 3600) / 60
            let seconds = Int(absInterval) % 60
            return "⏰ Overdue: \(days)d \(hours)h \(minutes)m \(seconds)s"
        }
        
        // If interval is positive, calculate remaining time
        let days = Int(interval) / 86400
        let hours = (Int(interval) % 86400) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        
        return "📆 \(days)d \(hours)h \(minutes)m \(seconds)s left"
    }

    var body: some View {
        VStack(spacing: 10) {
            // Animated Title
            Text("Harvard CS50X")
                .font(.largeTitle.bold())
                .foregroundStyle(
                    LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                )
                .scaleEffect(isAnimating ? 1.05 : 1)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        isAnimating = true
                    }

                    if let data = FileManagerHelper.shared.loadAppData() {
                        self.name = data.userName ?? "Your Name"
                        self.startDate = data.startDate ?? Date()
                        self.studyWeeks = data.studyWeeks

                        if data.userName == nil {
                            showNamePrompt = true
                        }
                    } else {
                        showNamePrompt = true
                    }

                    startTimer()
                }

            // Welcome Message
            HStack(spacing: 10) {
                Image("profile_photo")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .shadow(radius: 3)
                
                Text("Hi, \(name)! Stay focused and keep going 💪")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                
                Button(action: {
                    tempName = name
                    showNamePrompt = true
                }) {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                        .help("Edit Name")
                }
            }
            
            // Start Date Picker
            DatePicker("📅 Start Date", selection: $startDate, displayedComponents: [.date])
                .labelsHidden()
                .padding(.horizontal)
            
            // Study Duration
            Stepper("📘 Duration: \(studyWeeks) week(s)", value: $studyWeeks, in: 1...52)
                .padding(.horizontal)
            
            // Countdown Text
            Text(countdownText)
                .font(.headline)
                .foregroundColor(.orange)

        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 5)
        .padding()
        .sheet(isPresented: $showNamePrompt) {
            VStack(spacing: 20) {
                Text("👋 Welcome! What’s your name?")
                    .font(.title2)
                
                TextField("Enter your name", text: $tempName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                Button("Save") {
                    name = tempName
                    saveData()
                    showNamePrompt = false
                }
            }
            .padding()
            .frame(width: 350, height: 180)
        }
        .onChange(of: name) { _ in saveData() }
        .onChange(of: startDate) { _ in saveData() }
        .onChange(of: studyWeeks) { _ in saveData() }
    }

    private func saveData() {
        var current = FileManagerHelper.shared.loadAppData() ?? AppData(userName: nil, startDate: nil, studyWeeks: 12, paused: false, pausedAt: nil, urls: [])
        current.userName = name
        current.startDate = startDate
        current.studyWeeks = studyWeeks
        FileManagerHelper.shared.saveAppData(current)
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            now = Date()
        }
    }
}

