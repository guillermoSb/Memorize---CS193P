//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Guille on 11/05/21.
//

import Foundation



/// `EmojiMemoryGame` is the ViewModel for the `MemoryGame` model.
/// This handles the user intent to choose a card and sends the cards to the user
class EmojiMemoryGame: ObservableObject {
  
  //MARK:  Properties
  @Published private var memoryGame: MemoryGame = EmojiMemoryGame.createMemoryGame()
  static var selectedTheme: ThemeLibrary.Theme = {
    // Starts the new theme with a random one
    let randomThemeIndex = Int.random(in: 0..<ThemeLibrary().themeCount)  // Picks a random theme index
    return ThemeLibrary().themes[randomThemeIndex] // Sets the selected theme for all emojiMemoryGames
  }()
    
  
  // Get the MemoryGame Cards
  var cards: Array<MemoryGame<String>.Card> {
    memoryGame.cards
  }
  
  var score: Int {
    memoryGame.score
  } 
  
  
  
  //MARK: Static methods
  
  
  /// Creates a `MemoryGame` using an  `EmojiLibrary`
  static func createMemoryGame() -> MemoryGame<String> {
    var emojiLibrary = selectedTheme.content
    // Shuffle the emoji library to obtain random cards
    emojiLibrary.shuffle()
    // Create a memory game and shuffle the cards
    var memoryGame = MemoryGame(numberOfCardPairs: selectedTheme.content.count) { emojiLibrary[$0] }
    memoryGame.shuffleCards()
    // Set the memory game score to 0
    return memoryGame
  }
  
  // MARK: User Intents
  func choose(_ card: MemoryGame<String>.Card) {
    memoryGame.choose(card: card)
  }
  
  func newGame() {
    // Select theme
    let randomThemeIndex = Int.random(in: 0..<ThemeLibrary().themeCount)  // Picks a random theme index
    EmojiMemoryGame.selectedTheme = ThemeLibrary().themes[randomThemeIndex] // Sets the selected theme for all emojiMemoryGames
    self.memoryGame = EmojiMemoryGame.createMemoryGame()
  }
  
  
}

