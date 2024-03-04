//
//  HighlightItemModifier.swift
//
//
//  Created by Nico Dioso on 3/1/24.
//

import SwiftUI

public extension View {
  /**
   Highlights a specific area within the view based on an item.
   
   - Parameters:
     - item: An optional item that serves as a key to determine the area to be highlighted.
     - itemShape: A closure that returns a SwiftUI `View` representing the shape of the highlighted area. Defaults to a `Rectangle` if not provided.
     - onTap: A closure representing the action to be performed when the highlighted area is tapped.
   - Returns: A modified view with the specified highlight behavior.
   */
  func highlight<ID: Hashable, ItemShape: View>(
    _ id: ID?,
    @ViewBuilder itemShape: @escaping ()->ItemShape = { Rectangle() },
    onTap: @escaping ()->Void
  ) -> some View {
    self.highlight(
      id,
      itemShape: { _ in
        itemShape()
      }, 
      onTap: onTap
    )
  }
  
  /**
   Highlights a specific area within the view based on an item, using the item's bounds to define the shape.

   - Parameters:
     - item: An optional item that serves as a key to determine the area to be highlighted.
     - itemShape: A closure that takes a dictionary of `[Item: CGRect]` representing the bounds of the highlighted items and returns a SwiftUI `View` representing the shape of the highlighted area.
     - onTap: A closure representing the action to be performed when the highlighted area is tapped.
   - Returns: A modified view with the specified highlight behavior.
   */
  func highlight<ID: Hashable, ItemShape: View>(
    _ id: ID?,
    @ViewBuilder itemShape: @escaping ([ID: CGRect])->ItemShape,
    onTap: @escaping ()->Void
  ) -> some View {
    modifier(HighlightItemModifier(id: id, itemShape: itemShape, onTap: onTap))
  }
}

private struct HighlightItemModifier<ID: Hashable, ItemShape: View>: ViewModifier {
  
  let id: ID?
  @ViewBuilder let itemShape: ([ID: CGRect])->ItemShape
  let onTap: ()->Void
  
  func body(content: Content) -> some View {
    content
      .overlayPreferenceValue(BoundsPreferenceKey<ID>.self) { preferences in
        GeometryReader { geo in
          if let id,
             let itemRect = preferences[id] {
            let mappedRects = preferences.reduce(into: [:]) { $0[$1.key] = geo[$1.value] }
            Color.black.opacity(0.5)
              .reverseMask(alignment: .topLeading) {
                itemShape(mappedRects)
                  .frame(
                    width: geo[itemRect].width,
                    height: geo[itemRect].height
                  )
                  .offset(
                    x: geo[itemRect].minX,
                    y: geo[itemRect].minY
                  )
              }
              .onTapGesture(perform: onTap)
          }
        }
      }
  }
}
