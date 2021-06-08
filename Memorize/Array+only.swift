//
//  Array+only.swift
//  Memorize
//
//  Created by Guille on 13/05/21.
//

import Foundation

extension Array {
  /// Returns the only index for the array
  func onlyIndex() -> Element? {
    if count == 1 {
      return first!
    } else {
      return nil
    }
  }
}
