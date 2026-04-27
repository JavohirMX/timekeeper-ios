import Foundation
import SwiftUI




func toMinutes(time: Date, timezone: String) -> Int {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(identifier: timezone) ?? .current
    
    let comps = calendar.dateComponents([.hour, .minute], from: time)
    let h = comps.hour ?? 0
    let m = comps.minute ?? 0
    
    return h * 60 + m
}

func buildBusyBitset(profile: ProfileInfo) -> [Bool] {
    var busy = [Bool](repeating: false, count: 1440)
    
    for activity in profile.schedules {
        let start = toMinutes(time: activity.startTime, timezone: profile.timezoneIdentifier)
        let end = toMinutes(time: activity.endTime, timezone: profile.timezoneIdentifier)
        
        let s = max(0, min(1439, start))
        let e = max(0, min(1439, end))
        
        if s <= e {
            for i in s..<e {
                busy[i] = true
            }
        } else {
            // Overnight (e.g. 23:00 → 02:00)
            for i in s..<1440 { busy[i] = true }
            for i in 0..<e { busy[i] = true }
        }
    }
    
    return busy
}

func buildMutualFreeBitset(my: ProfileInfo, other: ProfileInfo) -> [Bool] {
    let myBusy = buildBusyBitset(profile: my)
    let otherBusy = buildBusyBitset(profile: other)
    
    var free = [Bool](repeating: false, count: 1440)
    
    for i in 0..<1440 {
        free[i] = !myBusy[i] && !otherBusy[i]
    }
    
    return free
}


func bitsetToRanges(_ free: [Bool]) -> [(start: Int, end: Int)] {
    var ranges: [(Int, Int)] = []
    
    var i = 0
    while i < 1440 {
        if free[i] {
            let start = i
            
            while i < 1440 && free[i] {
                i += 1
            }
            
            let end = i // exclusive
            ranges.append((start, end))
        } else {
            i += 1
        }
    }
    
    return ranges
}


func toDate(minutes: Int) -> Date {
    let hour = minutes / 60
    let minute = minutes % 60
    return timeSetter(hour: hour, minute: minute)
}


func getMutualFreeTimes(my: ProfileInfo, other: ProfileInfo) -> [Activity] {
    let freeBitset = buildMutualFreeBitset(my: my, other: other)
    let ranges = bitsetToRanges(freeBitset)
    
    return ranges.map { range in
        Activity(
            title: "Free time",
            icon: "person.badge.clock.fill",
            startTime: toDate(minutes: range.start),
            endTime: toDate(minutes: range.end)
        )
    }
}


////
////  FreeTime.swift
////  timekeeper
////
////  Created by Javohir Muhammad on 27/04/26.
////
//
//import Foundation
//import SwiftUI
//
//
//func getMutualFreeTimes(my: ProfileInfo, other: ProfileInfo) -> [Activity]? {
//    let freeMinutes = getMutualFreeMinutes(myProfile: my, otherProfile: other)
//    if freeMinutes == nil {return nil }
//    let groupedDates = getGroupedDates(freeMinutes: freeMinutes ?? [])
//    var freeTimes: [Activity] = []
//    
//    for groupedDate in groupedDates {
//        freeTimes.append(Activity(title: "Free time", icon: "person.badge.clock.fill", startTime: groupedDate[0], endTime: groupedDate[1]))
//    }
//    
//    return freeTimes
//}
//
//func getGroupedDates(freeMinutes: [Int]) -> [[Date]] {
//    let groupedMinutes = getGroupedMinutes(freeMinutes: freeMinutes)
//    var groupedDates: [[Date]] = []
//    
//    for groupedMinute in groupedMinutes{
//        groupedDates.append([toDate(minutes: groupedMinute[0]), toDate(minutes: groupedMinute[1])])
//    }
//    
//    return groupedDates
//}
//
////func getGroupedMinutes(freeMinutes: [Int]) -> [[Int]]? {
////    if freeMinutes.count < 1 {
////        return nil
////    }
////    let freeMinutes = freeMinutes.sorted()
////    var start: Int = 0
////    var current: Int = 1
////    var next: Int = 2
////    var groupedTimes: [[Int]] = []
////    while next < freeMinutes.count {
////        if freeMinutes[next] - freeMinutes[current] == 1 {
////            current += 1
////            next += 1
////        } else if freeMinutes[next] - freeMinutes[current] > 1 {
////            groupedTimes.append([freeMinutes[start], freeMinutes[current]])
////            start = next
////            current = next
////            next += 1
////        }
////        
////    }
////    groupedTimes.append([freeMinutes[start], freeMinutes[current]])
////    return groupedTimes.sorted { $0[0] < $1[0] }
////}
//
//func getGroupedMinutes(freeMinutes: [Int]) -> [[Int]] {
//    guard !freeMinutes.isEmpty else { return [] }
//    
//    let sorted = freeMinutes.sorted()
//    
//    var result: [[Int]] = []
//    var start = sorted[0]
//    var prev = sorted[0]
//    
//    for minute in sorted.dropFirst() {
//        if minute == prev + 1 || minute == prev{
//            prev = minute
//        } else {
//            result.append([start, prev])
//            start = minute
//            prev = minute
//        }
//    }
//    
//    result.append([start, prev+1])
//    return result
//}
//
//func getMutualFreeMinutes(myProfile: ProfileInfo, otherProfile: ProfileInfo) -> [Int]? {
//    let myFree: Set<Int> = Set(getFreeMinutes(profile: myProfile))
//    let otherFree: Set<Int> = Set(getFreeMinutes(profile: otherProfile))
//    let mutualFree: Set<Int> = myFree.intersection(otherFree)
//    let result = Array(mutualFree)
//    if result.isEmpty {return nil}
//    return result.sorted()
//}
//
//func getFreeMinutes(profile: ProfileInfo) -> [Int] {
//    let scheduleMinutes: [[Int]] = getScheduleMinutes(profile: profile)
//    
//    guard !scheduleMinutes.isEmpty else {
//        return Array(0...1439)
//    }
//    
//    var freeMinutes: [Int] = []
//    var current = 0
//    
//    for interval in scheduleMinutes {
//        let start = interval[0]
//        let end = interval[1]
//        
//        if start <= end {
//            if current < start {
//                freeMinutes.append(contentsOf: current..<start)
//            }
//            current = max(current, end)
//        } else {
//            // overnight split into two intervals
//            if current < start {
//                freeMinutes.append(contentsOf: current..<start)
//            }
//            current = max(current, 1440)
//            
//            if current < end {
//                freeMinutes.append(contentsOf: current..<end)
//            }
//            current = max(current, end)
//        }
//    }
//    
//    if current < 1440 {
//        freeMinutes.append(contentsOf: current..<1440)
//    }
//    
//    return freeMinutes.sorted()
//}
//
//func getScheduleMinutes(profile: ProfileInfo) -> [[Int]] {
//    let activities = profile.schedules
//    var actMin: [[Int]] = []
//    for activity in activities {
//        actMin.append([toMinutes(time: activity.startTime, timezone: profile.timezoneIdentifier), toMinutes(time: activity.endTime, timezone: profile.timezoneIdentifier)])
//    }
//    
//    //    return actMin
//    return actMin.sorted { $0[0] < $1[0] }
//}
//
//func toMinutes(time: Date, timezone: String = TimeZone.current.identifier) -> Int {
//    var calendar = Calendar.current
//    calendar.timeZone = TimeZone(identifier: timezone) ?? .current
//    let components = calendar.dateComponents([.hour, .minute], from: time)
//    let hour = Int(components.hour!)
//    let minute = Int(components.minute!)
//    let minutes = hour * 60 + minute
//    
//    return minutes
//}
//
//func toDate(minutes: Int) -> Date {
//    let hour: Int = minutes / 60
//    let minute: Int = minutes % 60
//    
//    return timeSetter(hour: hour, minute: minute)
//}
//
//struct SwiftUIView: View {
//    var body: some View {
//        let my = userProfile[0]
//        let other = defaultProfiles["nathan"]!
////        let myact = getScheduleMinutes(profile: my)
////        let act = getScheduleMinutes(profile: other)
//////        let gact = getGroupedMinutes(freeMinutes: act)
//        let freem = getMutualFreeMinutes(myProfile: my, otherProfile: other) ?? []
//        let free = getGroupedMinutes(freeMinutes: freem)
////        
////        let myfree = getFreeMinutes(profile: my)
////        let myfreeg = getGroupedMinutes(freeMinutes: myfree)
////        let otherfree = getFreeMinutes(profile: other)
////        
//        var mutualFreeTimes = getMutualFreeTimes(my: my, other: other)
////        let otherfreeg = getGroupedMinutes(freeMinutes: otherfree)
//        Text("\(mutualFreeTimes)")
//        Text("\(free)")
////        Text("\(myfreeg)")
////            .font(.caption2)
////        Text("\(otherfreeg)")
//    }
//}
//
//#Preview {
//    SwiftUIView()
//}
