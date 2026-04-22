//
//  TimeAlarm.swift
//  Temp code idk
//
//  Created by Ishandeep Singh on 17/04/26.
//

import SwiftUI

struct ProfileInfo: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let email: String
    let phNum: String
    let localTime: Date
    var schedules: [Schedule]
}

var userProfile: [ProfileInfo] = [
    ProfileInfo(name: "Ishandeep (Me)", imageName: "Ish", email: "ish.singh@gmail.com", phNum: "+65 9123 4567", localTime: timeSetter(hour: 14, minute: 0), schedules: defaultSchedule)
]

var defaultProfile: [ProfileInfo] = [
    ProfileInfo(name: "Johnny ", imageName: "john", email: "john@gmail.com", phNum: "+65 9123 4567", localTime: timeSetter(hour: 6, minute: 30), schedules: defaultSchedule),
    ProfileInfo(name: "Nataleen (Telolet)", imageName: "talin", email: "john@gmail.com", phNum: "+65 9123 4567", localTime: timeSetter(hour: 9, minute: 30), schedules: defaultSchedule),
    ProfileInfo(name: "Nathan", imageName: "nathan", email: "john@gmail.com", phNum: "+65 9123 4567", localTime: timeSetter(hour: 2, minute: 00), schedules: defaultSchedule),
    ProfileInfo(name: "Huy Tran", imageName: "huy", email: "john@gmail.com", phNum: "+65 9123 4567", localTime: timeSetter(hour: 16, minute: 00), schedules: defaultSchedule),
    ProfileInfo(name: "Nil", imageName: "nil", email: "john@gmail.com", phNum: "+65 9123 4567", localTime: timeSetter(hour: 16, minute: 00), schedules: defaultSchedule)
]



