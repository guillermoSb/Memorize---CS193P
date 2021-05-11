//
//  ContentView.swift
//  Memorize
//
//  Created by Guille on 6/05/21.
//

import SwiftUI


struct ContentView: View {
  var emojiMemoryGame: EmojiMemoryGame
  var body: some View {
    HStack {
      // Create a card view for each card on the model
      ForEach(emojiMemoryGame.cards) { (card) in
        CardView(content: card.content, font: emojiMemoryGame.cards.count < 5 ? .largeTitle : .title3)
          .onTapGesture {
            emojiMemoryGame.choose(card: card)  // Choose the card
          }
      }
    }
    .padding()
    .foregroundColor(.orange)
    .font(.largeTitle)
  }
}


/// Custom `CardView` is used for rendering cards. Needs to conform to the `View` protocol.
struct CardView: View {
  var isFaceUp: Bool = true
  var content: String
  var font: Font
  var body: some View {
    ZStack {
      if isFaceUp {
        RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
        RoundedRectangle(cornerRadius: 10.0).stroke()
        Text("\(content)").font(font)
      } else {
        RoundedRectangle(cornerRadius: 10.0).fill()
      }
    }
    .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
  }
}















































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView(emojiMemoryGame: EmojiMemoryGame())
    }
}
