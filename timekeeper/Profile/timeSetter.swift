//
//  TimeSetter.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 21/04/26.
//
import SwiftUI

func timeSetter(hour: Int, minute: Int) -> Date {
    let calendar = Calendar.current
    var components = DateComponents()
    components.year = 2000
    components.month = 1
    components.day = 1
    components.hour = hour
    components.minute = minute
    return calendar.date(from: components) ?? Date()
}
