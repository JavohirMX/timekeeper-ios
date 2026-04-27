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
    let timezoneIdentifier: String 
    var schedules: [Activity]
}

var userProfile: [ProfileInfo] = [
    ProfileInfo(name: "Ishandeep (Me)", imageName: "Ish", email: "ish.singh@gmail.com", phNum: "+65 9123 4567", timezoneIdentifier: TimeZone.current.identifier, schedules: defaultSchedule)
]

var defaultProfiles: [String: ProfileInfo] = [
    "john": ProfileInfo(name: "Johnny", imageName: "john", email: "john@gmail.com", phNum: "+65 9123 4567", timezoneIdentifier: "Asia/Tashkent", schedules: schedules["john"] ?? defaultSchedule),
    "talin": ProfileInfo(name: "Nataleen (Telolet)", imageName: "talin", email: "talin@gmail.com", phNum: "+65 9123 4567", timezoneIdentifier: "Australia/Sydney", schedules: defaultSchedule),
    "nathan": ProfileInfo(name: "Nathan", imageName: "nathan", email: "nathan@gmail.com", phNum: "+65 9123 4567", timezoneIdentifier: TimeZone.current.identifier, schedules: schedules["nathan"] ?? defaultSchedule),
    "huy": ProfileInfo(name: "Huy Tran", imageName: "huy", email: "huy@gmail.com", phNum: "+65 9123 4567", timezoneIdentifier: TimeZone.current.identifier, schedules: defaultSchedule),
    "nil": ProfileInfo(name: "Nil", imageName: "nil", email: "nil@gmail.com", phNum: "+65 9123 4567", timezoneIdentifier: TimeZone.current.identifier, schedules: defaultSchedule)
]


