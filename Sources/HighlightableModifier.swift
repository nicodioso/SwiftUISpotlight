//
//  HighlightableModifier.swift
//
//
//  Created by Nico Dioso on 3/1/24.
//

import SwiftUI

public extension View {
  /// Makes the view highlightable, allowing tracking of the bounds of a specific item within the view.
  ///
  /// - Parameters:
  ///   - id: The identifier of the item whose bounds need to be tracked.
  ///   - geometry: A `GeometryProxy` representing the geometry of the enclosing view.
  /// - Returns: A modified view with the specified behavior to track bounds.
  func highlightable<ID: Hashable>(
    id: ID,
    inside geometry: GeometryProxy
  ) -> some View {
    modifier(TrackBoundsModifier(id: id, geometry: geometry))
  }
  
  /// Makes the view highlightable with padding, allowing tracking of the bounds of a specific item within the view.
  ///
  /// - Parameters:
  ///   - id: The identifier of the item whose bounds need to be tracked.
  ///   - geometry: A `GeometryProxy` representing the geometry of the enclosing view.
  ///   - padding: The padding to apply around the highlighted area.
  /// - Returns: A modified view with the specified behavior to track bounds with padding.
  func highlightable<ID: Hashable>(
    id: ID,
    inside geometry: GeometryProxy,
    padding: CGFloat
  ) -> some View {
    highlightable(id: id, inside: geometry, padding: .all, padding)
  }
  
  /// Makes the view highlightable with customizable padding, allowing tracking of the bounds of a specific item within the view.
  ///
  /// - Parameters:
  ///   - id: The identifier of the item whose bounds need to be tracked.
  ///   - geometry: A `GeometryProxy` representing the geometry of the enclosing view.
  ///   - edge: The edge set to which the padding is applied.
  ///   - paddingValue: The value of the padding to apply along the specified edges.
  /// - Returns: A modified view with the specified behavior to track bounds with customizable padding.
  func highlightable<ID: Hashable>(
    id: ID,
    inside geometry: GeometryProxy,
    padding edge: Edge.Set,
    _ paddingValue: CGFloat
  ) -> some View {
    self
      .padding(edge, paddingValue)
      .highlightable(id: id, inside: geometry)
      .padding(edge, -paddingValue)
  }
}

private struct TrackBoundsModifier<ID: Hashable>: ViewModifier {
  
  let id: ID
  let geometry: GeometryProxy
  
  func body(content: Content) -> some View {
    content
      .anchorPreference(
        key: BoundsPreferenceKey.self,
        value: .bounds
      ) { [id: $0] }
  }
}
