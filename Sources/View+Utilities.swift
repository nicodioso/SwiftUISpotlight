//
//  View+Utilities.swift
//  
//
//  Created by Nico Dioso on 3/1/24.
//

import SwiftUI

internal extension View {
  @inlinable
  func reverseMask<Mask: View>(
    alignment: Alignment = .center,
    @ViewBuilder _ mask: () -> Mask
  ) -> some View {
    self.mask {
      Rectangle()
        .overlay(alignment: alignment) {
          mask()
            .blendMode(.destinationOut)
        }
    }
  }
}
