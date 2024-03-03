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
   
   Sample usage:
   ```
    .highlight(highlighted) { highlightedItem in
      switch highlightedItem {
         case .circularItem:
            Circle()
         case .roundedRectItem:
            RoundedRectangle(cornerRadius: 5)
         default:
            AnyView(Rectangle())
         }
      } onTap: {
         highlighted = nil
      }
   ```
   - Parameters:
   - item: An optional item that serves as a key to determine the area to be highlighted.
   - itemShape: A closure that returns a SwiftUI `View` representing the shape of the highlighted area. Defaults to a `Rectangle` if not provided.
     - onTap: A closure representing the action to be performed when the highlighted area is tapped.
     - Returns: A modified view with the specified highlight behavior.
   */
  func highlight<Item: Hashable, ItemShape: View>(
    _ item: Item?,
    @ViewBuilder itemShape: @escaping ()->ItemShape = { Rectangle() },
    onTap: @escaping ()->Void
  ) -> some View {
    modifier(HighlightItemModifier(item: item, itemShape: itemShape, onTap: onTap))
  }
}

private struct HighlightItemModifier<Item: Hashable, ItemShape: View>: ViewModifier {
  
  let item: Item?
  @ViewBuilder let itemShape: ()->ItemShape
  let onTap: ()->Void
  
  func body(content: Content) -> some View {
    content
      .overlayPreferenceValue(BoundsPreferenceKey<Item>.self) { preferences in
        GeometryReader { geo in
          if let item,
             let itemRect = preferences[item] {
            Color.black.opacity(0.5)
              .reverseMask(alignment: .topLeading) {
                itemShape()
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
