//
//  Activity.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 21/04/26.
//
import SwiftUI

struct Schedule: Identifiable {
    let id = UUID()
    let title: String
    let startTime: Date
    let endTime: Date
}

var defaultSchedule: [Schedule] = [
    Schedule(title: "Work", startTime: timeSetter(hour: 14, minute: 0), endTime: timeSetter(hour: 18, minute: 0)),
]
