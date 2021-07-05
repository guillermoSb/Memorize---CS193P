//
//  String+length.swift
//  Memorize
//
//  Created by Guille on 27/06/21.
//

import Foundation

extension String {
  func truncate(lenght: Int, terminator: String = "...") -> String {
    return self.trimmingCharacters(in: .whitespaces).count > lenght ? self.trimmingCharacters(in: .whitespaces).prefix(lenght).appending(terminator) : self
  }
}
