# SwiftUISpotlight
SwiftUISpotlight: Easily add highlighting functionality to SwiftUI views.

# Welcome to SwiftUISpotlight! 🌟

<img src="https://github.com/nicodioso/SwiftUISpotlight/assets/40595899/e1f6411e-dd79-4136-b08b-4e429753fa55" alt="SwiftUISpotlight Loop" width="270">

SwiftUISpotlight is your go-to repository for adding highlighting functionality to SwiftUI views with ease. Whether you need to emphasize specific areas within your app or guide users' attention, our `highlight` function simplifies the process. Define custom shapes for different items and handle taps effortlessly.



# Basic Highlighting
Here's a basic example of how to use SwiftUISpotlight to highlight a specific area within a view:

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
See `Examples/Example1.swift` for the demo video's code.
# Custom Highlight Shapes
You can define custom highlight shapes for each identifier using the .highlight(id) modifier:

```swift
.highlight(id: "myComponent1") {
    if id == "myComponent1" {
       Circle()
    } else {
       Rectangle()
    }
}
```
# Adding Padding
You can add padding to your highlightable areas using the .highlightable(id:inside:padding:) modifier:
```swift
.highlightable(id: "myComponent1", inside: geometry, padding: 10)
```
or

```swift
.highlightable(id: "myComponent1", inside: geometry, padding: .top, 10)
```
This allows you to customize the padding around the highlighted area.

# License
SwiftUISpotlight is available under the MIT license. See the LICENSE file for more information.


`
This README.md includes the additional features of defining custom highlight shapes for each identifier and adding padding to highlightable areas. It provides usage examples for each feature to help users understand how to incorporate them into their projects.
`
