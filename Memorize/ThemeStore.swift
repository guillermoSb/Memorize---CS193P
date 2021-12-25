//
//  ThemeStore.swift
//  Memorize
//
//  Created by Guille on 28/06/21.
//


import SwiftUI
import Combine

class ThemeStore: ObservableObject {
  
  @Published private(set) var themes: [Theme]
  private var autoSaveCancellable: AnyCancellable?
  init() {
    if let data = UserDefaults.standard.data(forKey: ThemeStore.themesKey) {
      self.themes = (try? JSONDecoder().decode(Array<Theme>.self, from: data)) ?? []
    } else {
      self.themes = []
    }
    autoSaveCancellable = $themes.sink(receiveValue: { themes in
      // Encode the themes
      let encodedThemes = try? JSONEncoder().encode(themes)
      // Save the themes on the local storage
      UserDefaults.standard.setValue(encodedThemes, forKey: ThemeStore.themesKey)
    })
  }
  
  func addEmoji(_ emojiString: String, to theme: Theme) {
    if let index = themes.index(for: theme) {
      let emojis = emojiString.components(separatedBy: "")
      themes[index].content.append(contentsOf: emojis)
      themes[index].content = themes[index].content.uniqued()
    }
  }
  
  // MARK: - INTENTS
  
  func addTheme() {
    var theme = ThemeStore.defaultTheme
    theme.id = UUID()
    themes.append(theme);
  }
  func removeTheme(at index: Int) {
    themes.remove(at: index)
  }
  func save(theme: Theme) {
    if let index = themes.index(for: theme) {
      themes[index] = theme
      print(themes)
    }
  }

  
  // MARK: - CONSTANTS
  static let defaultTheme = Theme(name: "Untitled", content: ["😀", "😆", "🥲", "🙂", "😍", "😙", "😝", "🧐"], rgb: UIColor(.orange).rgb, pairs: nil)
  static let themesKey = "MemorizeThemes3"
}
