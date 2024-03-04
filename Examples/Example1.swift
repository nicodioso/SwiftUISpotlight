//
//  Example1.swift
//  SwiftUISpotlight
//
//  Created by Nico Dioso on 3/2/24.
//

import SwiftUI
import SwiftUISpotlight

enum Item: Hashable, CaseIterable {
  case globe, text, textField, roundedRect, circle
  
  var description: String {
    switch self {
    case .globe:
      return "A globe icon"
    case .text:
      return "A simple text"
    case .textField:
      return "Input something here"
    case .roundedRect:
      return "A big rounded rectangle"
    case .circle:
      return "Circly shape"
    }
  }
}

struct ContentView: View {
  
  @State var string = ""
  @State var highlighted: Item? = nil
  
  let allItems = Item.allCases
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundStyle(.tint)
          .highlightable(id: Item.globe, inside: geometry, padding: 5)
          .onTapGesture {
            withAnimation {
              highlighted = .globe
            }
          }
        Text("Hello, world!")
          .highlightable(id: Item.text, inside: geometry, padding: 3)
          .onTapGesture {
            withAnimation {
              highlighted = .text
            }
          }
        HStack {
          TextField("My textfield", text: $string)
            .highlightable(id: Item.textField, inside: geometry, padding: .leading, 10)
            .onTapGesture {
              withAnimation {
                highlighted = .textField
              }
            }
          Spacer()
        }
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.green)
          .frame(height: 200)
          .highlightable(id: Item.roundedRect, inside: geometry)
          .onTapGesture {
            withAnimation {
              highlighted = .roundedRect
            }
          }
          .padding(.vertical, 80)
        HStack {
          Spacer()
          Circle()
            .fill(Color.yellow)
            .frame(width: 150, height: 150)
            .highlightable(id: Item.circle, inside: geometry)
            .onTapGesture {
              withAnimation {
                highlighted = .circle
              }
            }
        }
      }
      .padding()
    }
    .highlight(highlighted) { allBounds in
      let cornerRadius: CGFloat = {
        switch highlighted {
        case .globe:
          return allBounds[.globe]?.width ?? 0
        case .circle:
          return allBounds[.circle]?.width ?? 0
        case .roundedRect:
          return 10
        default:
          return 5
        }
      }()
      RoundedRectangle(cornerRadius: cornerRadius)
    } onTap: {
      guard let highlighted else { return }
      withAnimation {
        if let index = allItems.firstIndex(of: highlighted),
           index+1 < allItems.count {
          self.highlighted = allItems[index+1]
        } else {
          self.highlighted = nil
        }
      }
    }
    .overlay {
      ZStack {
        if let highlighted {
          Text(highlighted.description)
            .foregroundStyle(.white)
            .padding()
            .background{ RoundedRectangle(cornerRadius: 10) }
        }
      }
    }
  }
}
