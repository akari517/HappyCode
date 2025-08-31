//
//  ContentView.swift
//  spajam2025 Watch App
//
//  Created by 梶村拓斗 on 2025/08/30.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var sessionManager = WatchSessionManager()
    // MARK: - State
    @State private var isRunning = false
    @State private var startDate: Date?
    @State private var accumulated: TimeInterval = 0 // total elapsed when not running
    @State private var displayedElapsed: TimeInterval = 0

    // Timer to drive UI updates while running (lightweight interval for watch)
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                NavigationLink {
                    Sauna()
                }label: {
                    Text("サウナ")
                }
                
                NavigationLink {
                    Water()
                } label: {
                    Text("水風呂")
                }
                
                NavigationLink {
                    Gaikiyoku()
                } label: {
                    Text("外気浴")
                }
            }
        }
    }
    private func startWater() {
        
    }

    // MARK: - Actions
    private func toggleRun() {
        print("Toggle")
        if isRunning {
            // Pause
            if let start = startDate {
                accumulated += Date().timeIntervalSince(start)
            }
            startDate = nil
            isRunning = false
            displayedElapsed = accumulated
        } else {
            // Start
            startDate = Date()
            isRunning = true
        }
    }

    private func reset() {
        isRunning = false
        startDate = nil
        accumulated = 0
        displayedElapsed = 0
    }

    // MARK: - Formatting
    private func formattedTime(_ interval: TimeInterval) -> String {
        // Represent as H:MM:SS.hh when >= 1 hour, otherwise MM:SS.hh
        let hundredths = Int((interval * 100).rounded())
        let hours = hundredths / 360000
        let minutes = (hundredths / 6000) % 60
        let seconds = (hundredths / 100) % 60
        let hs = hundredths % 100

        if hours > 0 {
            return String(format: "%d:%02d:%02d.%02d", hours, minutes, seconds, hs)
        } else {
            return String(format: "%02d:%02d.%02d", minutes, seconds, hs)
        }
    }
}

#Preview {
    ContentView()
}
