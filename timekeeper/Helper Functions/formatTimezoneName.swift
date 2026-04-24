//
//  File.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 23/04/26.
//
import SwiftUI

func formatTimezoneName(_ identifier: String) -> String {
        let parts = identifier.split(separator: "/")
        guard parts.count == 2 else { return identifier.replacingOccurrences(of: "_", with: " ") }
        
        let continent = parts[0].replacingOccurrences(of: "_", with: " ")
        let city = parts[1].replacingOccurrences(of: "_", with: " ")
        return "\(city), \(continent)"
    }
