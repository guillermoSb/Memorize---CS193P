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
  @Published private var memoryGame: MemoryGame<String>
  var selectedTheme: Theme

  init(selectedTheme: Theme) {
    self.selectedTheme = selectedTheme
    let emojiLibrary = selectedTheme.content
    var memoryGame = MemoryGame(numberOfCardPairs: selectedTheme.pairs) { emojiLibrary[$0] }
    memoryGame.shuffleCards()
    self.memoryGame = memoryGame
  }
  
  // Get the MemoryGame Cards
  var cards: Array<MemoryGame<String>.Card> {
    memoryGame.cards
    
  }
  
  var score: Int {
    memoryGame.score
  }
  
  // MARK: User Intents
  func choose(_ card: MemoryGame<String>.Card) {
    memoryGame.choose(card: card)
  }
  
  func newGame() {
    self.memoryGame = createGame()
  }
  
  
  func createGame() -> MemoryGame<String> {
    let emojiLibrary = selectedTheme.content
    return MemoryGame(numberOfCardPairs: selectedTheme.pairs) {emojiLibrary[$0]}
  }
  
  
}

