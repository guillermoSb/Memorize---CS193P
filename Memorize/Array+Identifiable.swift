//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Guille on 12/05/21.
//

import Foundation

extension Array where Element: Identifiable {
  /// Gets an index for a certain element that conforms to `Identifiable`
  func index(for element: Element) -> Int? {
    for index in 0..<self.count {
      if element.id == self[index].id {
        return index
      }
    }
    return nil
  }
}
