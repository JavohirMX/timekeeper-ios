//
//  ProfileComponent.swift
//  timekeeper
//
//  Created by Ishandeep Singh on 21/04/26.
//

import SwiftUI

struct ProfileComponent:View {
    var profile: ProfileInfo
    var isMainUser: Bool
    var body: some View {
        NavigationLink() {
            ProfileDetails(profile: profile,
                           isMainUser: isMainUser)
                    }
        label: {
            HStack {
                Group {
                    if let data = profile.imageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 72, height: 72)
                            .clipped()
                            .clipShape(Circle())
                    } else {
                        Image(profile.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 72, height: 72)
                            .clipped()
                            .clipShape(Circle())
                    }
                }
                .padding(.trailing, 5)
                VStack(alignment: .leading){
                    Text(profile.name).font(.title2).fontWeight(.bold)
                    TimelineView(.periodic(from: .now, by: 1)) { context in
                        Text(Date(), style: .time)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        .environment(\.timeZone, TimeZone(identifier: profile.timezoneIdentifier) ?? .current)                }
                }
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
