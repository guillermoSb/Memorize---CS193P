//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Guille on 6/05/21.
//

import SwiftUI


struct EmojiMemoryGameView: View {
  @ObservedObject var emojiMemoryGame: EmojiMemoryGame
  
  var body: some View {
    
    NavigationView {
      VStack(content: {
        Text("\(EmojiMemoryGame.selectedTheme.name)")
          .padding(.top, 20)
          .transition(.opacity)
          .id("title" + EmojiMemoryGame.selectedTheme.name)
        Grid(emojiMemoryGame.cards) { (card) in
          CardView(card: card)
            .onTapGesture {
              withAnimation {
                self.emojiMemoryGame.choose(card)  // Choose the card
              }
            }
            .transition(.slide)
            .padding(5)
          
          
        }
        .padding()
        .foregroundColor(EmojiMemoryGame.selectedTheme.color)
        .navigationTitle("Score: \(emojiMemoryGame.score)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
          ToolbarItem(placement: ToolbarItemPlacement.automatic) {
            Button("New Game") {
              withAnimation {
                self.emojiMemoryGame.newGame()  // Create a New Game
                print(EmojiMemoryGame.selectedTheme.json?.utf8)
              }
            }
          }
        })
      })
    }
    .navigationViewStyle(StackNavigationViewStyle())
    
    
  }
  
  
}


/// Custom `CardView` is used for rendering cards. Needs to conform to the `View` protocol.
struct CardView: View {
  var card: MemoryGame<String>.Card
  var body: some View {
    
    GeometryReader(content: { geometry in
      body(for: geometry.size)
    })
  }
  
  @State private var animatedBonusRemaining : Double = 0
  
  private func startBonusTimeAnimation() {
    animatedBonusRemaining = card.bonusRemaining
    withAnimation(.linear(duration: card.bonusTimeRemaining)) {
      animatedBonusRemaining = 0
    }
  }
  
  
  
  @ViewBuilder
  func body(for size: CGSize) -> some View {
    if !(card.isMatched && !card.isFaceUp) {
      ZStack {
        Group {
          if card.isConsumingBonusTime {
            Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: -animatedBonusRemaining*360 - 90), clockwise: true)
              .onAppear {
                self.startBonusTimeAnimation()
              }

          } else {
            Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: -card.bonusRemaining*360 - 90), clockwise: true)
          }
        }
        .opacity(0.4).padding(5)
        Text("\(card.content)")
          .font(Font.system(size: fontSize(for: size)))
          .rotationEffect(card.isMatched ? Angle(degrees: 360): Angle(degrees: 0))
          .animation(card.isMatched ? Animation.linear.repeatForever(autoreverses: false).speed(0.6) : .none)
        
      }
      .cardify(isFaceUp: card.isFaceUp)
      
      .transition(.scale)
    }
    
  }
  
  private let cornerRadius: CGFloat = 10.0
  
  func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * 0.65
  }
}
















































struct ContentView_Previews: PreviewProvider {
  
  
  static var previews: some View {
    let game = EmojiMemoryGame()
    game.choose(game.cards[0])
    
    return Group {
      EmojiMemoryGameView(emojiMemoryGame: game)
    }
  }
}
