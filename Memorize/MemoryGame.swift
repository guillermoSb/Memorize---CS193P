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
/// - `score`: The game score
struct MemoryGame<CardContent> where CardContent: Equatable {
  var cards: Array<Card> = [] // Card array
  private(set) var score: Int = 0 // Game Score
  
  private var oneAndOnlyPossibleCardIndex: Int? {
    get {
      return cards.indices.filter {cards[$0].isFaceUp == true}.onlyIndex()
    }
    set {
      for i in cards.indices {
        cards[i].isFaceUp = i == newValue
      }
    }
  }
  
  
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
    // Set the score to 0
    self.score = 0
  }
  
  
  
  
  // MARK: Choose a Card
  
  /// Marks the `Card` received as chosen.
  mutating func choose(card: Card) {
    // Find card index
    if let index = cards.index(for: card), !cards[index].isFaceUp {
      
      
      
      if let possibleIndex = oneAndOnlyPossibleCardIndex {
        if cards[possibleIndex].content == cards[index].content {
          // Match
          cards[possibleIndex].isMatched = true
          cards[index].isMatched = true
          handleScore(outcome: .match, cards: [cards[possibleIndex], cards[index]])
        } else {
          // Miss Match
          handleScore(outcome: .miss, cards: [cards[possibleIndex], cards[index]])
          // Mark the card as seen
          cards[index].isSeen = true

        }
        cards[index].isFaceUp.toggle()

      } else {
        oneAndOnlyPossibleCardIndex = index
      }
      
    }
  }
  
  mutating func shuffleCards() {
    cards.shuffle()
  }
  
  /// Handles the score
  mutating func handleScore(outcome: Outcome, cards: [Card]) {
    switch outcome {
    case .match:
      score += 2
    default:
      for card in cards {
        if card.isSeen {
          score -= 1
        }
      }
    }
  }
  
  // MARK: Card Strcuct
  
  /// Defines all the properties of a `Card`.
  struct Card: Identifiable {
    var id = UUID()
    var content: CardContent
    var isFaceUp: Bool = false {
      didSet {
        if isFaceUp {
          startUsingBonusTime()
        } else {
          stopUsingBonusTime()
        }
      }
    }
    var isMatched: Bool = false {
      didSet {
        stopUsingBonusTime()
      }
    }
    var isSeen: Bool = false
    
    // MARK: Bonus Time
    
    var bonusTimeLimit: TimeInterval = 6
    
    private var faceUpTime: TimeInterval {
      if let lastFaceUpDate = self.lastFaceUpDate {
        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      } else {
        return pastFaceUpTime
      }
    }
    
    // Last time this card was turned face up
    var lastFaceUpDate: Date?
    
    // the accumulated time this card has been face up in the past
    // does not include current faceUpTime
    var pastFaceUpTime: TimeInterval = 0
    
    // How much time left before the bonus runs out
    var bonusTimeRemaining: TimeInterval {
      max(0, bonusTimeLimit - faceUpTime)
    }
    
    // Percentage of the bonus time remaining
    var bonusRemaining: Double {
      (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    // whether the card was matched during the bonus time period
    var hasEarnedBonus: Bool {
      isMatched && bonusTimeRemaining > 0
    }
    
    // whether the card face up, unmatched and have not uet used the bonus window
    var isConsumingBonusTime: Bool {
      isFaceUp && !isMatched && bonusTimeRemaining > 0
    }
    
    private mutating func startUsingBonusTime() {
      if isConsumingBonusTime, lastFaceUpDate == nil {
        lastFaceUpDate = Date()
      }
    }
    
    private mutating func stopUsingBonusTime() {
      pastFaceUpTime = faceUpTime
      self.lastFaceUpDate = nil
      
    }
    
    
    
  }

  
}

enum Outcome {
  case match, miss
}


