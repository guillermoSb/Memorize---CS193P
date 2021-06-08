//
//  Theme.swift
//  Memorize
//
//  Created by Guille on 18/05/21.
//

import SwiftUI

struct ThemeLibrary {
  
  
  var themes: [Theme] {
    [
      Theme(name: "Halloween", content: ["👻", "🎃", "🕷", "🔥", "🤡", "👾", "👺", "🧟‍♀️", "🧞", "🐉"], rgb: UIColor.orange.rgb),
      Theme(name: "Space", content: ["👩‍🚀", "👽", "🚀", "🛰", "🔭", "🌏", "📡", "🪐", "🌌", "⭐️"], rgb: UIColor.purple.rgb),
      Theme(name: "Animals", content: ["🐈‍⬛", "🦀", "🐈", "🐑", "🐇", "🦨", "🐔", "🐥"], rgb: UIColor.yellow.rgb),
      Theme(name: "Sports", content: ["⚽️", "🏀", "⚾️", "🏸", "🪃", "🎣", "🛹", "🏋️‍♀️", "🤺"], rgb: UIColor.red.rgb),
      Theme(name: "Transport", content: ["🚐", "🚚", "✈️", "🚀", "🛩", "🚦", "🚞", "🚠", "🛳"], rgb: UIColor.gray.rgb),
      Theme(name: "Food", content: ["🌭", "🌮", "🌯", "🌶", "🥐", "🥑", "🍔", "🍟", "🍥", "🍭", "🍳"], rgb: UIColor.systemPink.rgb)
    ]
  }
  
  var themeCount: Int {
    themes.count
  }
  
  
  struct Theme: Codable {
    var name: String
    var content: [String]
    var rgb: UIColor.RGB
    
    var json: Data? {
      try? JSONEncoder().encode(self)
    }
    
  }
  
}

extension ThemeLibrary.Theme {
  var color: Color { Color(self.rgb) }
}

