//
//  TimezoneSheet.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 23/04/26.
//

import SwiftUI

struct TimezoneSheet: View {
    @Binding var selectedTimezone: String
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    let allTimezones = TimeZone.knownTimeZoneIdentifiers
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return allTimezones
        } else {
            return allTimezones.filter { timeZone in
                timeZone.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        List {
            ForEach(searchResults, id: \.self) { timezone in
                Button(action: {
                    selectedTimezone = timezone
                    dismiss()
                }) {
                    // format "America/New_York" to look like "New York, America"
                    Text(formatTimezoneName(timezone))
                        .foregroundColor(.primary)
                }
            }
        }


        .searchable(text: $searchText, prompt: "Search")
        .navigationTitle("Choose a City")
        .navigationBarTitleDisplayMode(.inline)
    }
}
