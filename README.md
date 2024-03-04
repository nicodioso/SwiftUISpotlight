# SwiftUISpotlight
SwiftUISpotlight: Easily add highlighting functionality to SwiftUI views.

# Welcome to SwiftUISpotlight! 🌟

<img src="https://github.com/nicodioso/SwiftUISpotlight/assets/40595899/e1f6411e-dd79-4136-b08b-4e429753fa55" alt="SwiftUISpotlight Loop" width="270">

SwiftUISpotlight is your go-to repository for adding highlighting functionality to SwiftUI views with ease. Whether you need to emphasize specific areas within your app or guide users' attention, our `highlight` function simplifies the process. Define custom shapes for different items and handle taps effortlessly.

```swift
struct MyPage: View {
  @State var highlightedId: String? = nil

  var body: some View {
    GeometryReader { geometry in
      MyComponent()
        .highlightable(id: "myComponent", inside: geometry)
    }
    .highlight(
      highlightedId,
      onTap: {
        highlightedId = nil
      }
    )
    .task {
      highlightedId = "myComponent"
    }
  }
}
```
