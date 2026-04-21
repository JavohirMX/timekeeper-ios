

import SwiftUI

struct ScheduleView: View {
    // 360° maps to 24 hours. Therefore:
    // 15° = 1 hour, 1° = 4 minutes
    // Top (12 o'clock) is 0° mathematically.
    
    @State private var startAngle: Double = 0     // Bedtime (12:00 AM)
    @State private var toAngle: Double = 120      // Wake up (8:00 AM)
    private var times: [[Double]] = [[0,120],[150,180], [210,270]]
    private var colors: [Color] = [Color.blue, Color.green, Color.yellow]
    var icons: [String] = ["moon.fill", "fork.knife", "text.book.closed.fill"]
    
    private var times2: [[Double]] = [[70,170],[250,290], [310,350]]
    private var colors2: [Color] = [Color.yellow, Color.green, Color.yellow]
    
    @State private var selection = "You"
    let friends = ["You", "Micheal"]
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Schedule")
                .font(.system(size: 36, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                
//            Spacer()
            // MARK: - Central Sleep Duration Display
//            VStack(spacing: 8) {
//                Text(getSleepDuration())
//                    .font(.system(size: 44, weight: .bold, design: .rounded))
//                
//                Text("Sleep Duration")
//                    .font(.headline)
//                    .foregroundColor(.secondary)
//            }
            
            // MARK: - Circular Slider
            GeometryReader { proxy in
                let width = proxy.size.width
                let center = CGPoint(x: width / 2, y: width / 2)
                let radius = width / 2
//                Text("\(radius)")
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    // 1. Inner Clock Ticks
                    ForEach(0..<120, id: \.self) { i in
                        Rectangle()
                            .fill(i % 10 == 0 ? Color.primary : Color.gray.opacity(0.3))
                            .frame(width: 2, height: i % 10 == 0 ? 12 : 5)
                            .offset(y: -radius + 55) // Indent the ticks slightly
                            .rotationEffect(.degrees(Double(i) * 3))
                    }
                    
                    let hoursPM = ["12PM", "2PM", "4PM", "6PM", "8PM", "10PM"]
                    ForEach(hoursPM.indices, id: \.self) { index in
                        Text("\(hoursPM[index])")
                            .font(.caption)
                            .foregroundColor(.primary.opacity(index % 3 == 0 ? 1 : 0.6))
                            .rotationEffect(.init(degrees: Double(index) * -30))
                            .offset(y: (width - 70) / 3)
                            .rotationEffect(.degrees(Double(index) * 30))
                                
                    }
                    let hoursAM = ["12AM", "2AM", "4AM", "6AM", "8AM", "10AM"]
                    ForEach(hoursAM.indices, id: \.self) { index in
                        Text("\(hoursAM[index])")
                            .font(.caption)
                            .foregroundColor(.primary.opacity(index % 3 == 0 ? 1 : 0.6))
                            .rotationEffect(.init(degrees: Double(index) * -30+180))
                            .offset(y: (width - 70) / 3)
                            .rotationEffect(.degrees(Double(index) * 30+180))
                                
                    }
                    
                    // 2. Track Background
                    
                        
                    Circle()
                        .fill(Color.black)
                        .zIndex(-2)
                        .frame(width: 235)
                    Circle()
                        .fill(Color.gray.opacity(0.7))
                        .zIndex(-1)
                        .frame(width: 15)
                    Circle()
                        .fill(Color.orange)
                        .frame(height: 280)
                        .zIndex(-5)
                    Circle()
                        .fill(Color.mint.opacity(0.9))
                        .frame(width: 330)
                        .zIndex(-6)
                    Circle()
                        .fill(Color.clear)
                        .frame(width: .infinity)
                        .zIndex(-99)
                    Path { path in
                        path.move(to: CGPoint(x: radius, y: radius-9))
                        path.addLine(to: CGPoint(x: 300, y: 330))
                    }
                    .stroke(.red, lineWidth: 2)
                    .zIndex(2)
                    
                    Text("9.40am")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        .position(x: 310, y: 345)

                    
                    ForEach(times.indices, id: \.self) {ind in
                        ActivityComponent(startAngle: times[ind][0], toAngle:times[ind][1], radius: radius, center: center, color: colors[ind], extraSpace: 0, iconName: icons[ind])
                    }
                    
                    ForEach(times2.indices, id: \.self) {ind in
                        ActivityComponent(startAngle: times2[ind][0], toAngle:times2[ind][1], radius: radius+23, center: center, color: colors2[ind], extraSpace: 47, iconName: icons[ind])
                    }

                }
                .coordinateSpace(name: "slider") // Used by DragGesture to ensure coordinates are relative to the center
            }
            .frame(width: .infinity, height: 350)
            Spacer()
            Spacer()
            VStack {
                Picker("Select a color", selection: $selection) {
                    ForEach(friends, id: \.self) { friend in
                        Text(friend).tag(friend)
                    }
                }
                .pickerStyle(.segmented) // Converts the picker to a segmented control
                
//                Text("Selected: \(selection)")
            }
            .padding()
            // MARK: - Bottom Time Labels
//            HStack(spacing: 50) {
//                TimeDisplayView(title: "Bedtime", time: getTime(angle: startAngle), icon: "moon.zzz.fill")
//                TimeDisplayView(title: "Wake up", time: getTime(angle: toAngle), icon: "alarm.fill")
//            }
            
        }
        .padding()
    }
    
    // MARK: - Mathematical Helpers
    
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
    private func getTime(angle: Double) -> String {
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
    private func getSleepDuration() -> String {
        let difference = (toAngle - startAngle).truncatingRemainder(dividingBy: 360)
        let normalizedDiff = difference < 0 ? difference + 360 : difference
        
        let totalMinutes = normalizedDiff * 4
        let hours = Int(totalMinutes / 60)
        let minutes = Int(totalMinutes.truncatingRemainder(dividingBy: 60))
        
        return "\(hours)h \(minutes)m"
    }
}

// MARK: - Reusable UI Components

struct KnobView: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.primary)
            .frame(width: 40, height: 40)
//            .background(Color.white)
            .clipShape(Circle())
            // Keeps the icon from rotating upside down even though its container is rotated
            .rotationEffect(.degrees(90))
            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
    }
}

struct TimeDisplayView: View {
    var title: String
    var time: String
    var icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Text(time)
                .font(.title2.bold())
        }
    }
}

#Preview {
    ScheduleView()
        .preferredColorScheme(.dark)
}
