//
//  Activity.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 21/04/26.
//
import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let startTime: Date
    let endTime: Date
    
    func startAngle() -> Double {
        
        // 360° maps to 24 hours. Therefore:
        // 15° = 1 hour, 1° = 4 minutes, 1 minute = 0.25°
        // Top (12 o'clock) is 0° mathematically.
        let hour = Double(Calendar.current.component(.hour, from: startTime))
        let minute = Double(Calendar.current.component(.minute, from: startTime))
        let angle = Double(hour * 15 + minute * 0.25)
        
        return angle + 3.75 // + 15 minutes for rounded corner addition
    }
    
    func toAngle() -> Double {
        
        // 360° maps to 24 hours. Therefore:
        // 15° = 1 hour, 1° = 4 minutes, 1 minute = 0.25°
        // Top (12 o'clock) is 0° mathematically.
        let hour = Double(Calendar.current.component(.hour, from: endTime))
        let minute = Double(Calendar.current.component(.minute, from: endTime))
        let angle = Double(hour * 15 + minute * 0.25)
        
        return angle - 3.75 // - 15 minutes fpr rounded corner
    }
}

var defaultSchedule: [Activity] = [
    Activity(title: "Work", icon: "briefcase.fill", startTime: timeSetter(hour: 14, minute: 0), endTime: timeSetter(hour: 18, minute: 0)),
]
