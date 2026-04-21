//
//  ActivityComponent.swift
//  timekeeper
//
//  Created by Javohir Muhammad on 21/04/26.
//

import SwiftUI

struct ActivityComponent: View {
    var startAngle: Double
    var toAngle: Double
    let radius: CGFloat
    let center: CGPoint
    let color: Color
    let extraSpace: CGFloat
    let iconName: String
    
    var body: some View {
        // 3. Highlighted Sleep Track
        // Calculate the difference, normalizing negative values so it properly wraps around midnight
        let difference = (toAngle - startAngle).truncatingRemainder(dividingBy: 360)
        let normalizedDiff = difference < 0 ? difference + 360 : difference
        
        Circle()
            .trim(from: 0, to: normalizedDiff / 360)
            .stroke(color, style: StrokeStyle(lineWidth: 25, lineCap: .round, lineJoin: .round))
            // We subtract 90° so that mathematical 0° starts at the top (12 o'clock) instead of the right (3 o'clock)
            .rotationEffect(.degrees(startAngle - 90))
            .frame(width: 259 + extraSpace)
        
        
        // 4. Bedtime Knob (Start)
        KnobView(imageName: iconName)
            .offset(x: radius-55)
            .rotationEffect(.degrees(startAngle - 90))
//            .gesture(
//                DragGesture(minimumDistance: 0, coordinateSpace: .named("slider"))
//                    .onChanged { value in
//                        startAngle = getAngle(location: value.location, center: center)
//                    }
//            )
        
        // 5. Wake Up Knob (End)
//        KnobView(imageName: "alarm")
//            .offset(x: radius-55)
//            .rotationEffect(.degrees(toAngle - 90))
//            .gesture(
//                DragGesture(minimumDistance: 0, coordinateSpace: .named("slider"))
//                    .onChanged { value in
//                        toAngle = getAngle(location: value.location, center: center)
//                    }
//            )
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

#Preview {
    var startAngle: Double = 0
    var toAngle: Double = 120
    let width: CGFloat = 350
    let center = CGPoint(x: width / 2, y: width / 2)
    let radius = width / 2
    ActivityComponent(startAngle: startAngle, toAngle: toAngle, radius: radius, center: center, color: Color.blue, extraSpace: 0, iconName: "moon.fill")
}
