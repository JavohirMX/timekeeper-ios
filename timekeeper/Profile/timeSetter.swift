//
//  TimeSetter.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 21/04/26.
//
import SwiftUI

func timeSetter(hour: Int, minute: Int, timezoneIdentifier: String = TimeZone.current.identifier) -> Date {
    var calendar = Calendar.current
    if let targetTimeZone = TimeZone(identifier: timezoneIdentifier) {
            calendar.timeZone = targetTimeZone
        }
    var components = DateComponents()
    components.year = 2026
    components.month = 1
    components.day = 1
    components.hour = hour
    components.minute = minute
    return calendar.date(from: components) ?? Date()
}
