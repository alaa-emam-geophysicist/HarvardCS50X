//
//  CountdownView.swift
//  HarvardCS50X
//
//  Created by Alaa Emam on 4/30/25.
//

//  DEPRECATED - Not in use anymore Merged to topsectionview

//import SwiftUI
//
//struct CountdownView: View {
//    @ObservedObject var model = AppModel.shared
//    @State private var now = Date()
//    @State private var timer: Timer?
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            if model.appData.startDate == nil {
//                DatePicker("Select Start Date", selection: Binding(
//                    get: { Date() },
//                    set: { model.appData.startDate = $0 }
//                ), displayedComponents: .date)
//
//                Stepper("Study Duration: \(model.appData.studyWeeks) week(s)", value: $model.appData.studyWeeks, in: 1...52)
//            } else {
//                Text("Study End Date: \(endDate.formatted(date: .abbreviated, time: .shortened))")
//                    .font(.footnote)
//                    .foregroundColor(.secondary)
//
//                Text(remainingTimeString())
//                    .font(.title2)
//                    .bold()
//
//                HStack {
//                    Button(model.appData.paused ? "Resume" : "Pause") {
//                        togglePause()
//                    }
//                    .buttonStyle(.bordered)
//
//                    Button("Reset") {
//                        model.appData.startDate = nil
//                        model.appData.paused = false
//                        model.appData.pausedAt = nil
//                    }
//                    .foregroundColor(.red)
//                    .buttonStyle(.borderedProminent)
//                    
//                }
//            }
//        }
//        .padding()
//        .onAppear {
//            startTimer()
//        }
//        .onDisappear {
//            timer?.invalidate()
//        }
//    }
//
//    var endDate: Date {
//        guard let start = model.appData.startDate else { return Date() }
//        return Calendar.current.date(byAdding: .day, value: model.appData.studyWeeks * 7, to: start)!
//    }
//
//    func remainingTimeString() -> String {
//        guard let start = model.appData.startDate else { return "" }
//
//        let targetDate = endDate
//        let currentDate = model.appData.paused ? (model.appData.pausedAt ?? now) : now
//        let interval = targetDate.timeIntervalSince(currentDate)
//
//        let absInterval = abs(Int(interval))
//        let days = absInterval / 86400
//        let hours = (absInterval % 86400) / 3600
//        let minutes = (absInterval % 3600) / 60
//        let seconds = absInterval % 60
//
//        let prefix = interval < 0 ? "+" : "⏳"
//        return "\(prefix) \(days)d \(hours)h \(minutes)m \(seconds)s"
//    }
//
//    func togglePause() {
//        if model.appData.paused {
//            // Resuming
//            if let pausedAt = model.appData.pausedAt {
//                let timePaused = Date().timeIntervalSince(pausedAt)
//                model.appData.startDate?.addTimeInterval(timePaused)
//            }
//            model.appData.paused = false
//            model.appData.pausedAt = nil
//        } else {
//            // Pausing
//            model.appData.paused = true
//            model.appData.pausedAt = Date()
//        }
//    }
//
//    func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            now = Date()
//        }
//    }
//}
