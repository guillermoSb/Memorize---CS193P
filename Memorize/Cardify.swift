//
//  Cardify.swift
//  Memorize
//
//  Created by Guille on 22/05/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
  
  var angle: Double
  
  var animatableData: Double {
    get {self.angle}
    set {self.angle = newValue}
  }
  
  var isFaceUp: Bool {
    self.angle < 90
  }
  
  init(isFaceUp: Bool) {
    self.angle = isFaceUp ? 0 : 180
  }
  

  func body(content: Content) -> some View {
    ZStack {
      Group {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cornerRadius).stroke()
        content
        
      }
      RoundedRectangle(cornerRadius: cornerRadius).fill()
        .opacity(isFaceUp ? 0 : 1)
    }
    .rotation3DEffect(
      Angle(degrees: angle),
      axis: (0,1,0)
    )
    
    
    
    
    
  }
  
  private let cornerRadius: CGFloat = 10.0
  
}

extension View {
  func cardify(isFaceUp: Bool) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp))
  }
}
