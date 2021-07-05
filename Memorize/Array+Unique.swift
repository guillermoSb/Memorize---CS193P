//
//  Array+Unique.swift
//  Memorize
//
//  Created by Guille on 29/06/21.
//

import Foundation

extension Array where Element: Hashable {
  func uniqued() -> [Element] {
    var set = Set<Element>()
    
    return self.filter {
      set.insert($0).inserted
    }
  }
}
