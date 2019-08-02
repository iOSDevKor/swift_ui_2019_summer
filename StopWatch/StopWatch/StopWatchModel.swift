//
//  StopWatchModel.swift
//  StopWatch
//
//  Copyright © 2019 keyWindow. All rights reserved.
//

import Foundation
import Combine

class StopWatch : ObservableObject {
   
    struct Time : Hashable {
        private let minute: Int
        private let second: Int
        private let milisecond: Int
        
        var formattedString: String {
            return String(format: "%02d:%02d:%02d", minute, second, milisecond)
        }
        
        init() {
            self.init(timeInterval: 0)
        }
        
        init(timeInterval: TimeInterval) {
            var timeInterval = timeInterval
            let minute = Int(timeInterval / 60.0)
            timeInterval -= (TimeInterval(minute) * 60)
             
            let second = Int(timeInterval)
            timeInterval -= TimeInterval(second)
             
            let millisecond = Int(timeInterval * 100)
            
            self.minute = minute
            self.second = second
            self.milisecond = millisecond
        }
    }
    
    @Published var userName = "USER"
    @Published var laps: [Time] = []
    @Published var currentTime: Time = Time()
    @Published var isPaused: Bool = false
    
    private var started: Date = Date()
    private var paused: Date = Date()
    private var pauseInterval: TimeInterval = 0
    private var timer: Timer?
    private var timeIntervalToNow: TimeInterval {
        -(started.timeIntervalSinceNow - pauseInterval)
    }
    
    func reset() {
        started = Date()
        paused = Date()
        isPaused = false
        currentTime = Time()
        laps.removeAll()
        pauseInterval = 0
    }
    
    func addLap() {
        laps.insert(Time(timeInterval: timeIntervalToNow), at: 0)
    }
    
    func start() {
        if isPaused {
            pauseInterval += paused.timeIntervalSinceNow
        } else {
            started = Date()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            self.currentTime = Time(timeInterval: self.timeIntervalToNow)
        }
        timer?.fire()
        isPaused = false
    }
    
    func stop() {
        paused = Date()
        isPaused = true
        timer?.invalidate()
        timer = nil
    }
    
}
