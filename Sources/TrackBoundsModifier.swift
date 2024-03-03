//
//  TrackBoundsModifier.swift
//
//
//  Created by Nico Dioso on 3/1/24.
//

import SwiftUI

public extension View {
  /// Tracks the bounds of a specific item within the view.
  ///
  /// - Parameters:
  ///   - item: The item whose bounds need to be tracked.
  ///   - geometry: A `GeometryProxy` representing the geometry of the enclosing view.
  /// - Returns: A modified view with the specified behavior to track bounds.
  func trackBounds<Item: Hashable>(
    item: Item,
    inside geometry: GeometryProxy
  ) -> some View {
    modifier(TrackBoundsModifier(item: item, geometry: geometry))
  }
}

private struct TrackBoundsModifier<Item: Hashable>: ViewModifier {
  
  let item: Item
  let geometry: GeometryProxy
  
  func body(content: Content) -> some View {
    content
      .anchorPreference(
        key: BoundsPreferenceKey.self,
        value: .bounds
      ) { [item: $0] }
  }
}
