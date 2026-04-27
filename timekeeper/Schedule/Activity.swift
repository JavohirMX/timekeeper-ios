//
//  Activity.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 21/04/26.
//
import SwiftUI
import SwiftData

@Model
class Activity: Identifiable {
    var id = UUID()
    var title: String
    var icon: String
    var startTime: Date
    var endTime: Date
    
    init(id: UUID = UUID(), title: String, icon: String, startTime: Date, endTime: Date) {
            self.id = id
            self.title = title
            self.icon = icon
            self.startTime = startTime
            self.endTime = endTime
        }
    
    
    func startAngle(timezone: String = TimeZone.current.identifier) -> Double {
    
        // 360° maps to 24 hours. Therefore:
        // 15° = 1 hour, 1° = 4 minutes, 1 minute = 0.25°
        // Top (12 o'clock) is 0° mathematically.
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: timezone)!
        let components = calendar.dateComponents([.hour, .minute], from: startTime)
        let hour = Double(components.hour!)
        let minute = Double(components.minute!)
        let angle = Double(hour * 15 + minute * 0.25)
        if self.title == "Free time"{
            return angle + 1
        }
        return angle + 3.75 // + 15 minutes for rounded corner addition
    }
    
    func toAngle(timezone: String = TimeZone.current.identifier) -> Double {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: timezone)!
        let components = calendar.dateComponents([.hour, .minute], from: endTime)
        let hour = Double(components.hour!)
        let minute = Double(components.minute!)
        let angle = Double(hour * 15 + minute * 0.25)
        if self.title == "Free time"{
            return angle - 1
        }
        return angle - 3.75 // - 15 minutes for rounded corner
    }
}
var defaultSchedule = [
    Activity(title: "Sleep", icon: "moon.fill", startTime: timeSetter(hour: 4, minute: 0), endTime: timeSetter(hour: 11, minute: 0)),
    Activity(title: "Study", icon: "text.book.closed.fill", startTime: timeSetter(hour: 14, minute: 0), endTime: timeSetter(hour: 18, minute: 0)),
    Activity(title: "Lunch", icon: "fork.knife", startTime: timeSetter(hour: 18, minute: 30), endTime: timeSetter(hour: 19, minute: 20)),
    Activity(title: "Work", icon: "briefcase.fill", startTime: timeSetter(hour: 20, minute: 0), endTime: timeSetter(hour: 1, minute: 0)),
]

var schedules: [String: [Activity]] = [
    "john" : [
        Activity(title: "Sleep", icon: "moon.fill", startTime: timeSetter(hour: 4, minute: 0), endTime: timeSetter(hour: 11, minute: 0)),
        Activity(title: "Study", icon: "text.book.closed.fill", startTime: timeSetter(hour: 14, minute: 0), endTime: timeSetter(hour: 18, minute: 0)),
        Activity(title: "Lunch", icon: "fork.knife", startTime: timeSetter(hour: 18, minute: 30), endTime: timeSetter(hour: 19, minute: 20)),
        Activity(title: "Work", icon: "briefcase.fill", startTime: timeSetter(hour: 20, minute: 0), endTime: timeSetter(hour: 1, minute: 0)),
    ],
    "nathan" : [
        Activity(title: "Sleep", icon: "moon.fill", startTime: timeSetter(hour: 23, minute: 30), endTime: timeSetter(hour: 7, minute: 30)),
        Activity(title: "Breakfast", icon: "fork.knife", startTime: timeSetter(hour: 7, minute: 50), endTime: timeSetter(hour: 8, minute: 30)),
        Activity(title: "Uni work", icon: "briefcase.fill", startTime: timeSetter(hour: 9, minute: 0), endTime: timeSetter(hour: 11, minute: 30)),
        Activity(title: "Academy", icon: "text.book.closed.fill", startTime: timeSetter(hour: 13, minute: 0), endTime: timeSetter(hour: 17, minute: 0)),
        Activity(title: "Gym", icon: "dumbbell.fill", startTime: timeSetter(hour: 19, minute: 0), endTime: timeSetter(hour: 20, minute: 30)),
    ]
    
]
