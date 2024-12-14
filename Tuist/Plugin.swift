// swift-tools-version: 6.0
import ProjectDescription

let plugin = Plugin(
    name: "SwiftLint",
    packages: [
        .package(url: "https://github.com/realm/SwiftLint", from: "0.50.0")
    ]
)
