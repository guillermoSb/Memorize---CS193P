//
//  MemoryGame.swift
//  Memorize
//
//  Created by Guille on 6/05/21.
//

import Foundation



/// `MemoryGame` model handles cards information.
/// Properties:
/// - `cards`: An array of `Card`
struct MemoryGame<CardContent> {
  var cards: Array<Card> = []
  
  // MARK: Initializer
  /// Initializes the `MemoryGame`. Receives the `numberOfCardPairs` and a `cardContentFactory`.
  /// For each pair creates two cards with a cardContent
  init(numberOfCardPairs: Int, cardContentFactory: (Int) -> CardContent) {
    for i in 0..<numberOfCardPairs {
      // Define the cards content
      let content = cardContentFactory(i)
      // Create two cards
      cards.append(Card(content: content))
      cards.append(Card(content: content))
    }
  }
  
  
  
  // MARK: Choose a Card
  
  /// Marks the `Card` received as chosen.
  func choose(card: Card) {
    print("Card chosen: \(card)")
  }
  
  // MARK: Card Strcuct
  
  /// Defines all the properties of a `Card`.
  struct Card: Identifiable {
    var id = UUID()
    var content: CardContent
    var chosen: Bool = false
  }
  
}


