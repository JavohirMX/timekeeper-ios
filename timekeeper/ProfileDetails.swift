
import SwiftUI

struct SecondScreen: View {
    var profile: ProfileInfo
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    Image(profile.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                    
                    Text(profile.name)
                        .font(.title)
                        .bold()
                    
                    VStack(spacing: -5) {
                        Text(Date(), style: .time)
                            .font(.system(size: 60, weight: .light))
                            .foregroundStyle(.white)
                            .environment(\.timeZone, TimeZone(identifier: profile.timezoneIdentifier) ?? .current)
                        Text("Local Time")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .textCase(.uppercase)
                            .tracking(2) //increase spacing between characters
                    }
                }
                .frame(maxWidth: .infinity)//to centre the v stack to the middle of the page
                .listRowBackground(Color.black) //to change this individual list row background and not the others
            }
            
            Section {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundStyle(.orange)
                    Text("Email")
                    Spacer()
                    Text(profile.email)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundStyle(.orange)
                    Text("Phone")
                    Spacer()
                    Text(profile.phNum)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("Contact")
            }
            
            Section {
                ForEach(profile.schedules) { event in
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(event.title)
                                .font(.title3)
                                .bold()
                            
                            HStack() {
                                Image(systemName: "clock")
                                Text(event.startTime, style: .time)
                                Text("-")
                                Text(event.endTime, style: .time)
                            }
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
            } header: {
                Text("Schedule")
            }
            
            Section {
                Button {/* TODO:ACTION!!!! */} label: {
                    HStack {
                        Spacer()
                        Image(systemName: "clock.arrow.trianglehead.2.counterclockwise.rotate.90")
                        Text("Compare Schedule")
                            .font(.headline)
                            .bold()
                        Spacer()
                    }
                    .padding(.vertical, 6)
                }
                .listRowBackground(Color.orange)
                .foregroundStyle(.white)
            }
        }
        .listStyle(.insetGrouped)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    print("Edit button tapped")
                }
                .tint(.orange)
            }
        }
    }
}

#Preview {
    SecondScreen(profile: defaultProfiles["john"]!)
        .preferredColorScheme(.dark)
}
