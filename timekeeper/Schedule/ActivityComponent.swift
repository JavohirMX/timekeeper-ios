//
//  ActivityComponent.swift
//  timekeeper
//
//  Created by Javohir Muhammad on 21/04/26.
//

import SwiftUI

struct ActivityComponent: View {
    var activity: Activity
    //    var startAngle: Double
    //    var toAngle: Double
    let radius: CGFloat
    let center: CGPoint
    let color: Color
    let extraSpace: CGFloat
    let timezone: String
    //    let iconName: String
    @State private var showPopover = false
    var body: some View {
        // Highlighted Sleep Track
        // Calculate the difference, normalizing negative values so it properly wraps around midnight
        let difference = (activity.toAngle() - activity.startAngle()).truncatingRemainder(dividingBy: 360)
        let normalizedDiff = difference < 0 ? difference + 360 : difference
        let startTime = Text(activity.startTime, style: .time)
        let endTime = Text(activity.endTime, style: .time)
        
        if activity.title == "Free time" {
            Circle()
                .trim(from: 0, to: normalizedDiff / 360)
    //                    .fill()
                .stroke(color, style: StrokeStyle(lineWidth: showPopover ? 54 : 48, lineCap: .butt))
            // We subtract 90° so that mathematical 0° starts at the top (12 o'clock) instead of the right (6 o'clock)
                .rotationEffect(.degrees(activity.startAngle(timezone: timezone) - 90))
                .frame(width: 258 + extraSpace)
                .onTapGesture {
                    showPopover.toggle()
                }
                .confirmationDialog(
                    "\(activity.title)",
                    isPresented: $showPopover,
                    titleVisibility: .visible
                ) {
                    
                } message: {
                    Image(systemName: "clock")
                    Text("\(startTime) - \(endTime)")
                }
        } else {
            Circle()
                .trim(from: 0, to: normalizedDiff / 360)
    //                    .fill()
                .stroke(color, style: StrokeStyle(lineWidth: showPopover ? 28 : 24, lineCap: .round))
            // We subtract 90° so that mathematical 0° starts at the top (12 o'clock) instead of the right (6 o'clock)
                .rotationEffect(.degrees(activity.startAngle(timezone: timezone) - 90))
                .frame(width: 258 + extraSpace)
                .onTapGesture {
                    showPopover.toggle()
                }
                .confirmationDialog(
                    "\(activity.title)",
                    isPresented: $showPopover,
                    titleVisibility: .visible
                ) {
                    
                } message: {
                    Image(systemName: "clock")
                    Text("\(startTime) - \(endTime)")
                }

            
            // Bedtime Knob (Start)
            KnobView(imageName: activity.icon)
                .offset(x: radius-56)
                .rotationEffect(.degrees(activity.startAngle(timezone: timezone) - 88))
            //            .gesture(
            //                DragGesture(minimumDistance: 0, coordinateSpace: .named("slider"))
            //                    .onChanged { value in
            //                        startAngle = getAngle(location: value.location, center: center)
            //                    }
            //            )
        }
        
        
        
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
}

struct KnobView: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.primary)
            .frame(width: 40, height: 40)
        //                    .background(Color.white)
            .clipShape(Circle())
        // Keeps the icon from rotating upside down even though its container is rotated
            .rotationEffect(.degrees(90))
            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
    }
}
#Preview {
    let activity: Activity = Activity(title: "Work", icon: "briefcase.fill", startTime: timeSetter(hour: 14, minute: 0), endTime: timeSetter(hour: 18, minute: 0))
    let width: CGFloat = 350
    let center = CGPoint(x: width / 2, y: width / 2)
    let radius = width / 2
    ActivityComponent(activity: activity, radius: radius, center: center, color: Color.blue, extraSpace: 0, timezone: TimeZone.current.identifier)
}
