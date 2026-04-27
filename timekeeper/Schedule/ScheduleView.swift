import SwiftUI
import SwiftData

struct ScheduleView: View {
    @Query(filter: #Predicate<ProfileInfo> { $0.isMainUser == true }) var mainUsers: [ProfileInfo]
    @Query(filter: #Predicate<ProfileInfo> { $0.isMainUser == false }, sort: \ProfileInfo.name) var connections: [ProfileInfo]
//    var schedule1: [Activity] = [
//        Activity(title: "Work", icon: "briefcase.fill", startTime: timeSetter(hour: 14, minute: 0), endTime: timeSetter(hour: 18, minute: 0)),
//        Activity(title: "Sleep", icon: "moon.fill", startTime: timeSetter(hour: 23, minute: 0), endTime: timeSetter(hour: 7, minute: 0)),
//        Activity(title: "Lunch", icon: "fork.knife", startTime: timeSetter(hour: 12, minute: 20), endTime: timeSetter(hour: 13, minute: 10)),
//        Activity(title: "Study", icon: "text.book.closed.fill", startTime: timeSetter(hour: 8, minute: 0), endTime: timeSetter(hour: 12, minute: 0)),
//    ]
//    
//    var schedule2: [Activity] = [
//        Activity(title: "Sleep", icon: "moon.fill", startTime: timeSetter(hour: 4, minute: 0), endTime: timeSetter(hour: 11, minute: 0)),
//        Activity(title: "Study", icon: "text.book.closed.fill", startTime: timeSetter(hour: 14, minute: 0), endTime: timeSetter(hour: 18, minute: 0)),
//        Activity(title: "Lunch", icon: "fork.knife", startTime: timeSetter(hour: 18, minute: 30), endTime: timeSetter(hour: 19, minute: 20)),
//        Activity(title: "Work", icon: "briefcase.fill", startTime: timeSetter(hour: 20, minute: 0), endTime: timeSetter(hour: 1, minute: 0)),
//    ]
//    
    //@State private var selectedProfile: String = "john"
//    let friends = defaultProfiles.map { (key, profile) in
//        (id: key, name: profile.name)
//    }
    @State private var selectedProfileId: UUID? = nil
    
    @State var currentHourAngle: Double = 0
    @State var currentTime: String = "0.00"
    
    //    var losAngelesHour: Int {
    //            var calendar = Calendar.current
    //            calendar.timeZone = TimeZone(identifier: "America/Los_Angeles") ?? .current
    //            return calendar.component(.hour, from: Date())
    //        }
    
    var body: some View {
        
        VStack(spacing: 50) {
            Text("Schedule")
                .font(.system(size: 36, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            // MARK: - Circular Slider
            GeometryReader { proxy in
                let width = proxy.size.width
                let center = CGPoint(x: width / 2, y: width / 2)
                let radius = width / 2
                //                Text("\(radius)")
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    // Inner Clock Ticks
                    ForEach(0..<144, id: \.self) { i in
                        Rectangle()
                            .fill(i % 6 == 0 ? Color.primary : Color.gray.opacity(0.3))
                            .frame(width: 2, height: i % 6 == 0 ? 12 : 5)
                            .offset(y: -radius + 56) // Indent the ticks slightly
                            .rotationEffect(.degrees(Double(i) * 2.5))
                    }
                    ForEach(0..<144, id: \.self) { i in
                        Rectangle()
                            .fill(i % 6 == 0 ? Color.primary : Color.gray.opacity(0.3))
                            .frame(width: 2, height: i % 6 == 0 ? 12 : 5)
                            .offset(y: -radius + 33) // Indent the ticks slightly
                            .rotationEffect(.degrees(Double(i) * 2.5))
                    }
                    
                    // Clock Hour Labels
                    let hoursPM = ["12PM", "2PM", "4PM", "6PM", "8PM", "10PM"]
                    ForEach(hoursPM.indices, id: \.self) { index in
                        Text("\(hoursPM[index])")
                            .font(.caption)
                            .bold(index % 3 == 0 ? true : false)
                            .foregroundColor(.primary.opacity(index % 3 == 0 ? 1 : 0.6))
                            .rotationEffect(.init(degrees: Double(index) * -30))
                            .offset(y: (width - 70) / 3)
                            .rotationEffect(.degrees(Double(index) * 30))
                        
                    }
                    let hoursAM = ["12AM", "2AM", "4AM", "6AM", "8AM", "10AM"]
                    ForEach(hoursAM.indices, id: \.self) { index in
                        Text("\(hoursAM[index])")
                            .font(.caption)
                            .bold(index % 3 == 0 ? true : false)
                            .foregroundColor(.primary.opacity(index % 3 == 0 ? 1 : 0.6))
                            .rotationEffect(.init(degrees: Double(index) * -30+180))
                            .offset(y: (width - 70) / 3)
                            .rotationEffect(.degrees(Double(index) * 30+180))
                        
                    }
                    Image(systemName: "sun.max.fill")
                        .foregroundStyle(Color.yellow)
                        .offset(y: (width - 50) / 4)
                    Image(systemName: "moon.fill")
                        .foregroundStyle(Color.indigo)
                        .offset(y: -(width - 50) / 4)
                    
                    
                    
                    // Clock
                    
                    Circle()
                        .fill(Color(.systemBackground))
                        .zIndex(-2)
                        .frame(width: 235)
                    Circle()
                        .fill(Color.gray)
                        .zIndex(3)
                        .frame(width: 15)
                    Circle()
                        .fill(Color.clockGray)
                        .frame(height: 280)
                        .zIndex(-5)
                    Circle()
                        .fill(Color.clockGray.opacity(0.6))
                        .frame(width: 330)
                        .zIndex(-6)
                    
                    // Hour handle
                    Path { path in
                        path.move(to: CGPoint(x: radius, y: radius+5))
                        path.addLine(to: CGPoint(x: radius, y: 25))
                    }
                    .stroke(.orange, lineWidth: 2)
                    .zIndex(2)
                    .rotationEffect(.degrees(currentHourAngle))
                    
                    // Current Time
                    Text("\(currentTime)")
                        .font(.caption)
                        .foregroundColor(Color.primary)
                        .rotationEffect(.init(degrees: -currentHourAngle))
                        .offset(y: -(width) / 2)
                        .rotationEffect(.degrees(currentHourAngle))
                    
                    // Activities
                    
                    
                    // 1. Draw Your Schedule (Inner Circle)
                    if let myProfile = mainUsers.first {
                        let innerCircle = myProfile.schedules
                        ForEach(innerCircle) { activity in
                            ActivityComponent(
                                activity: activity,
                                radius: radius,
                                center: center,
                                color: Color.lightGreen,
                                extraSpace: 0,
                                timezone: myProfile.timezoneIdentifier
                            )
                        }
                    }
                    
                    // 2. Draw Friend's Schedule (Outer Circle)
                    if let selectedId = selectedProfileId,
                       let secondProfile = connections.first(where: { $0.id == selectedId }) {
                        
                        let outerCircle = secondProfile.schedules
                        ForEach(outerCircle) { activity in
                            ActivityComponent(
                                activity: activity,
                                radius: radius + 23,
                                center: center,
                                color: Color.darkOrange,
                                extraSpace: 47,
                                timezone: secondProfile.timezoneIdentifier
                            )
                        }
                    }
                    
                    // Mutual free times
                    if let myProfile = mainUsers.first, let selectedId = selectedProfileId,
                       let secondProfile = connections.first(where: { $0.id == selectedId }) {
                        let mutualFreeTimes = getMutualFreeTimes(my: myProfile, other: secondProfile)
                        
                        if !mutualFreeTimes.isEmpty {
                            ForEach(mutualFreeTimes.indices, id: \.self) {ind in
                                ActivityComponent(activity: mutualFreeTimes[ind], radius: radius, center: center, color: Color.orange.opacity(0.3), extraSpace: 25, timezone: myProfile.timezoneIdentifier)
                            }
                        }
                    }
                    
                }
                //.coordinateSpace(name: "slider") // Used by DragGesture to ensure coordinates are relative to the center
            }
            .frame(height: 390)
            Spacer()
            Spacer()
            HStack {
                Text("Comparing schedule with:")
                
                Picker("Select", selection: $selectedProfileId) {
                    Text("None").tag(UUID?(nil)) // A default blank option
                    
                    //loop through live connections
                    ForEach(connections) { friend in
                        Text(friend.name).tag(UUID?(friend.id))
                    }
                }
                .pickerStyle(.menu)
            }
        }
        .padding()
        .onAppear {
            updateClock()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                updateClock()
            }
            if selectedProfileId == nil {
                    selectedProfileId = connections.first?.id
                }
        }
    }
    
    // MARK: - Helpers
    
    private func getTimeAngle() -> Double {
        // 360° maps to 24 hours. Therefore:
        // 15° = 1 hour, 1° = 4 minutes, 1 minute = 0.25°
        // Top (12 o'clock) is 0° mathematically.
        let hour = Double(Calendar.current.component(.hour, from: Date()))
        let minute = Double(Calendar.current.component(.minute, from: Date()))
        let angle = Double(hour * 15 + minute * 0.25)
        
        return angle
    }
    private func getTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let minute = Calendar.current.component(.minute, from: Date())
        let extra = minute < 10 ? "0" : ""
        return "\(hour).\(extra)\(minute)"
    }
    private func updateClock() {
        currentHourAngle = getTimeAngle()
        currentTime = getTime()
    }
    /// Converts a dragged coordinate back into an angle mapped strictly between 0° and 360°
    private func getAngle(location: CGPoint, center: CGPoint) -> Double {
        let vector = CGVector(dx: location.x - center.x, dy: location.y - center.y)
        let angle = atan2(vector.dy, vector.dx)
        
        // Add 90 to offset the visual -90 degree rotation applied to our slider
        var degree = angle * 180 / .pi + 90
        if degree < 0 { degree += 360 }
        
        // Snap the drag to 5-minute increments (1.25 degrees) to simulate real Apple Clock behavior
        return (degree / 1.25).rounded() * 1.25
    }
    
    /// Converts a circular angle into formatted standard times (e.g. "8:00 AM")
    private func getTimeFromAngle(angle: Double) -> String {
        let totalMinutes = angle * 4
        let hours = Int(totalMinutes / 60)
        let minutes = Int(totalMinutes.truncatingRemainder(dividingBy: 60))
        
        var components = DateComponents()
        components.hour = hours
        components.minute = minutes
        
        guard let date = Calendar.current.date(from: components) else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    /// Computes the delta string between the two points
    //    private func getDuration() -> String {
    //        let difference = (toAngle - startAngle).truncatingRemainder(dividingBy: 360)
    //        let normalizedDiff = difference < 0 ? difference + 360 : difference
    //
    //        let totalMinutes = normalizedDiff * 4
    //        let hours = Int(totalMinutes / 60)
    //        let minutes = Int(totalMinutes.truncatingRemainder(dividingBy: 60))
    //
    //        return "\(hours)h \(minutes)m"
    //    }
    
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
    
    
    static let clockGray = Color(hex: "#6C757D")
    static let lightGreen = Color(hex: "#52b788")
    static let darkGreen = Color(hex: "#2d6a4f")
    
    static let lightOrange = Color(hex: "#ffaa00")
    static let darkOrange = Color(hex: "#ff8500")
    
    
}

#Preview {
    ScheduleView()
        .preferredColorScheme(.dark)
}
