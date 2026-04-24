//
//  ProfileComponent.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 21/04/26.
//

import SwiftUI

struct ProfileComponent:View {
    var profile: ProfileInfo
    var body: some View {
        NavigationLink() {
            ProfileDetails(profile: $profile)
        }
        label: {
            HStack {
                Image(profile.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 72)
                    .clipped()
                    .clipShape(Circle())
                    .padding(.trailing, 5)
                VStack(alignment: .leading){
                    Text(profile.name).font(.title2).fontWeight(.bold)
                    Text(Date(), style: .time)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .environment(\.timeZone, TimeZone(identifier: profile.timezoneIdentifier) ?? .current)                }
                Spacer()
            }
        }
        .padding()
        .frame(height: 100)
        .contentShape(Rectangle())
        .buttonStyle(.plain)
        .listRowInsets(EdgeInsets())
    }
}
