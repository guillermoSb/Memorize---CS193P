//
//  Data+String.swift
//  Memorize
//
//  Created by Guille on 8/06/21.
//

import Foundation

extension Data {
  var utf8: String? {String(data: self, encoding: .utf8)}
}
