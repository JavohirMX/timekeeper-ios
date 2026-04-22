

import SwiftUI

struct ScheduleView: View {
    // 360° maps to 24 hours. Therefore:
    // 15° = 1 hour, 1° = 4 minutes
    // Top (12 o'clock) is 0° mathematically.
    
    @State private var startAngle: Double = 0     // Bedtime (12:00 AM)
    @State private var toAngle: Double = 120      // Wake up (8:00 AM)
    var times: [[Double]] = [[0,120],[150,180], [210,270]]
    var colors: [Color] = [Color.color2, Color.color2, Color.color2]
    var icons: [String] = ["moon.fill", "fork.knife", "text.book.closed.fill"]
    
    private var times2: [[Double]] = [[70,170],[250,290], [310,350]]
    private var colors2: [Color] = [Color.color4, Color.color4, Color.color4]
    
    @State private var selection = "You"
    let friends = ["You", "Micheal"]
    
    @State var currentHourAngle: Double = 0
    @State var currentTime: String = "0.00"
    
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
                    ForEach(0..<120, id: \.self) { i in
                        Rectangle()
                            .fill(i % 10 == 0 ? Color.primary : Color.gray.opacity(0.3))
                            .frame(width: 2, height: i % 10 == 0 ? 12 : 5)
                            .offset(y: -radius + 55) // Indent the ticks slightly
                            .rotationEffect(.degrees(Double(i) * 3))
                    }
                    
                    // Clock Hour Labels
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
                    
                    // Clock
                    
                    Circle()
                        .fill(Color.black)
                        .zIndex(-2)
                        .frame(width: 235)
                    Circle()
                        .fill(Color.gray)
                        .zIndex(3)
                        .frame(width: 15)
                    Circle()
                        .fill(Color.color1)
                        .frame(height: 280)
                        .zIndex(-5)
                    Circle()
                        .fill(Color.color1.opacity(0.6))
                        .frame(width: 330)
                        .zIndex(-6)
                    Circle()
                        .fill(Color.clear)
                        .frame(width: .infinity)
                        .zIndex(-99)
                    
                    
                    // Hour handle
                    Path { path in
                        path.move(to: CGPoint(x: radius, y: radius+5))
                        path.addLine(to: CGPoint(x: radius, y: 20))
                    }
                    .stroke(.red, lineWidth: 2)
                    .zIndex(2)
                    .rotationEffect(.degrees(currentHourAngle))
                    
                    // Current Time
                    Text("\(currentTime)")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        .rotationEffect(.init(degrees: -currentHourAngle))
                        .offset(y: -(width + 10) / 2)
                        .rotationEffect(.degrees(currentHourAngle))

                    // Activities
                    ForEach(times.indices, id: \.self) {ind in
                        ActivityComponent(startAngle: times[ind][0], toAngle:times[ind][1], radius: radius, center: center, color: colors[ind], extraSpace: 0, iconName: icons[ind])
                    }
                    
                    ForEach(times2.indices, id: \.self) {ind in
                        ActivityComponent(startAngle: times2[ind][0], toAngle:times2[ind][1], radius: radius+23, center: center, color: colors2[ind], extraSpace: 47, iconName: icons[ind])
                    }
                    
                }
                //.coordinateSpace(name: "slider") // Used by DragGesture to ensure coordinates are relative to the center
            }
            .frame(width: .infinity, height: 390)
            Spacer()
            Spacer()
            
            // Segmented picker
            VStack {
                Picker("Select", selection: $selection) {
                    ForEach(friends, id: \.self) { friend in
                        Text(friend).tag(friend)
                    }
                }
                .pickerStyle(.segmented) // Converts the picker to a segmented control
                
            }
            .padding()
            
            
        }
        .padding()
        .onAppear {
            updateClock()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                updateClock()
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
        
        return "\(hour).\(minute)"
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
    private func getDuration() -> String {
        let difference = (toAngle - startAngle).truncatingRemainder(dividingBy: 360)
        let normalizedDiff = difference < 0 ? difference + 360 : difference
        
        let totalMinutes = normalizedDiff * 4
        let hours = Int(totalMinutes / 60)
        let minutes = Int(totalMinutes.truncatingRemainder(dividingBy: 60))
        
        return "\(hours)h \(minutes)m"
    }
    
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
    
    
    static let color1 = Color(hex: "#6C757D")
    static let color2 = Color(hex: "#52b788")
    static let color3 = Color(hex: "#6b9080")
    static let color4 = Color(hex: "#2d6a4f")
    
}

#Preview {
    ScheduleView()
        .preferredColorScheme(.dark)
}
