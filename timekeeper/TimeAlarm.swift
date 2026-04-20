//
//  TimeAlarm.swift
//  Temp code idk
//
//  Created by Ishandeep Singh on 17/04/26.
//

import SwiftUI

struct TimeAlarm: Identifiable {
    let id = UUID()
    let time: String
    var isOn: Bool
}

var defaultAlarms: [TimeAlarm] = [
    TimeAlarm(time: "08.00", isOn: true),
    TimeAlarm(time: "14.00", isOn: false),
    TimeAlarm(time: "08.00", isOn: true),
    TimeAlarm(time: "14.00", isOn: false),
    TimeAlarm(time: "08.00", isOn: true),
    TimeAlarm(time: "14.00", isOn: false)
]
