//
//  TimeAlarm.swift
//  Temp code idk
//
//  Created by Ishandeep Singh on 17/04/26.
//

import SwiftUI
import SwiftData

@Model
class ProfileInfo: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
    var email: String
    var phNum: String
    var timezoneIdentifier: String
    var schedules: [Activity]
    var imageData: Data? = nil
    var isMainUser: Bool = false
    
    init(id: UUID = UUID(), name: String, imageName: String, email: String, phNum: String, timezoneIdentifier: String, schedules: [Activity] = [], imageData: Data? = nil, isMainUser: Bool = false) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.email = email
        self.phNum = phNum
        self.timezoneIdentifier = timezoneIdentifier
        self.schedules = schedules
        self.imageData = imageData
        self.isMainUser = isMainUser
    }
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

