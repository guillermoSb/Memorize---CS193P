//
//  Pie.swift
//  Memorize
//
//  Created by Guille on 22/05/21.
//

import SwiftUI

struct Pie: Shape {
  
  var startAngle: Angle
  var endAngle: Angle
  var clockwise = false
  
  var animatableData: AnimatablePair<Double, Double> {
    get {
      AnimatablePair(startAngle.radians, endAngle.radians)
    }
    set {
      startAngle = Angle.radians(newValue.first)
      endAngle = Angle.radians(newValue.second)
    }
  }
  
  func path(in rect: CGRect) -> Path {
    // Define drawing constants
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    let start = CGPoint(
      x: center.x + radius * CGFloat(cos(startAngle.radians)),
      y: center.y + radius * CGFloat(sin(startAngle.radians))
    )
    // Draw the Pie Path
    
    var path = Path() // Create the path
    path.move(to: center)  // Move to the center
    path.addLine(to: start)
    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    path.addLine(to: center)
    
    
    return path
  }
  
  
}
