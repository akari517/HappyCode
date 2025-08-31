//
//  sauna.swift
//  example.happyCode Watch App
//
//  Created by 梶村拓斗 on 2025/08/31.
//

import Foundation
import SwiftUICore
import HealthKit
import SwiftUI

struct Sauna: View {
    var body: some View {
        VStack {
            
            TimerBaseView(title: "サウナ")
        }
    }
}

struct TimerBaseView: View {
    let title: String
    @State private var isRunning = false
    @State private var startDate: Date?
    @State private var accumulated: TimeInterval = 0 // total elapsed when not running
    @State private var displayedElapsed: TimeInterval = 0
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            
            
            VStack(spacing: 12) {
                Text(formattedTime(displayedElapsed))
                    .font(.system(size: 34, weight: .semibold, design: .rounded))
                    .monospacedDigit()
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .padding(.vertical, 6)

                HStack(spacing: 10) {
                    Button(action: toggleRun) {
                        Label(isRunning ? "一時停止" : "開始",
                              systemImage: isRunning ? "pause.fill" : "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)

                    NavigationLink{
                        Water()
                    } label: {
                        Text("水風呂")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }

                Text("心拍数：124")
                    .font(.system(size: 25))
                    .foregroundColor(.red)
            }
            .padding()
            // Drive the displayed time while running
            .onReceive(timer) { _ in
                if isRunning, let start = startDate {
                    displayedElapsed = accumulated + Date().timeIntervalSince(start)
                } else {
                    displayedElapsed = accumulated
                }
            }
            // Ensure the displayed time is correct on appear
            .onAppear {
                displayedElapsed = accumulated
            }
        }
    }
    

    func getHeartRate() async {
        var heartRate = "78"
        guard HKHealthStore.isHealthDataAvailable() else {
            await MainActor.run {
                heartRate = "Health data is not available on this device."
            }
                return
        }
        
        guard let heartType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            await MainActor.run { heartRate = "HeartRate type unavailable." }
                    return
                }

                let sort = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                let query = HKSampleQuery(sampleType: heartType,
                                          predicate: nil,
                                          limit: 1,
                                          sortDescriptors: [sort]) { _, samples, error in
                    if let error = error {
                        Task { @MainActor in
                            heartRate = "Query error: \(error.localizedDescription)"
                        }
                        return
                    }

                    guard let sample = samples?.first as? HKQuantitySample else {
                        Task { @MainActor in
                            heartRate = "No heart rate data."
                        }
                        return
                    }

                    let bpmUnit = HKUnit.count().unitDivided(by: .minute())
                    let bpm = sample.quantity.doubleValue(for: bpmUnit)
                    let value = String(format: "%.0f bpm", bpm)

                    Task { @MainActor in
                        heartRate = "\(value)"
                    }
                }

                healthStore.execute(query)
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
    // healthkitの権限セット
    func requestAuthorization() async {
        print("54")
        let allTypes: Set = [
            HKQuantityType.workoutType(),
            HKQuantityType(.activeEnergyBurned),
            HKQuantityType(.distanceCycling),
            HKQuantityType(.distanceWalkingRunning),
            HKQuantityType(.distanceWheelchair),
            HKQuantityType(.heartRate),
            HKQuantityType(.restingHeartRate)
        ]
        print("62")
        do {
            // Check that Health data is available on the device.
            if HKHealthStore.isHealthDataAvailable() {
                
                // Asynchronously request authorization to the data.
                //
                try await healthStore.requestAuthorization(toShare: allTypes, read: allTypes)
            }
        } catch {
            
            // Typically, authorization requests only fail if you haven't set the
            // usage and share descriptions in your app's Info.plist, or if
            // Health data isn't available on the current device.
            fatalError("*** An unexpected error occurred while requesting authorization: \(error.localizedDescription) ***")
        }
        print("あいうえお")
    }
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
}
