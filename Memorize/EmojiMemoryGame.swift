//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Guille on 11/05/21.
//

import Foundation



/// `EmojiMemoryGame` is the ViewModel for the `MemoryGame` model.
/// This handles the user intent to choose a card and sends the cards to the user
class EmojiMemoryGame {
  
  //MARK:  Properties
  private var memoryGame: MemoryGame = EmojiMemoryGame.createMemoryGame()
  // Get the MemoryGame Cards
  var cards: Array<MemoryGame<String>.Card> {
    get {
      memoryGame.cards.shuffled()
    }
  }
  
  //MARK: Static methods
  
  /// Creates a `MemoryGame` using an  `EmojiLibrary`
  static func createMemoryGame() -> MemoryGame<String> {
    var emojiLibrary = ["👻", "🎃", "🕷", "🔥", "🤡", "👾", "👺", "🧟‍♀️", "🧞", "🐉"] // TODO: Add more emojis and initialize a random number of pairs
    // Shuffle the emoji library to obtain random cards
    emojiLibrary.shuffle()
    return MemoryGame(numberOfCardPairs: Int.random(in: 2...5)) { emojiLibrary[$0] }
  }
  
  // MARK: User Intents
  func choose(card: MemoryGame<String>.Card) {
    memoryGame.choose(card: card)
  }
  
}

