//
//  BoundsPreferenceKey.swift
//
//
//  Created by Nico Dioso on 3/1/24.
//

import SwiftUI

struct BoundsPreferenceKey<Item: Hashable>:  PreferenceKey {
  typealias Value = [Item: Anchor<CGRect>]
  
  static var defaultValue: Value { [:] }
  
  static func reduce(
    value: inout Value,
    nextValue: () -> Value
  ) {
    value.merge(nextValue()) { $1 }
  }
}
