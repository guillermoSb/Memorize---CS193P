//
//  ContentView.swift
//  Memorize
//
//  Created by Guille on 6/05/21.
//

import SwiftUI

struct ContentView: View {
  // Define el tipo con some - Significa que el tipo de esa variable es cualquier cosa siempre que sea un view.
  // Esta variable no es guardada si no que se calcula cada vez que se llama la variable
  var body: some View {
    // Esta en puntos
    HStack {
      ForEach(0..<4) { index in
        CardView(isFaceUp: false)
      }
    }
    .padding()
    .foregroundColor(.orange)
    .font(.largeTitle)
  }
}


struct CardView: View {
  var isFaceUp: Bool
  var body: some View {
    ZStack {
      if isFaceUp {
        RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
        RoundedRectangle(cornerRadius: 10.0).stroke()
        Text("👻")
      } else {
        // Fills using the foreground color on the Hstack
        RoundedRectangle(cornerRadius: 10.0).fill()
      }


    }
  }
}















































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
