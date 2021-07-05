//
//  Theme.swift
//  Memorize
//
//  Created by Guille on 18/05/21.
//

import SwiftUI


struct Theme: Codable, Identifiable {
  var name: String
  var content: [String]
  var pairs: Int
  var id = UUID()
  
  init(name: String, content: [String], rgb: UIColor.RGB, pairs: Int?) {
    self.name = name
    self.content = content
    self.pairs = content.count
    if let pairs = pairs {
      self.pairs = min(pairs, content.count)
    }
    self.rgb = rgb
  }
  
  var rgb: UIColor.RGB
  var json: Data? {
    try? JSONEncoder().encode(self)
  }
  
  
}



extension Theme {
  var color: Color { Color(self.rgb) }
}

