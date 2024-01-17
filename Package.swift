// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "Intercom",
  platforms: [.macOS(.v10_15)],
  products: [
    .library(name: "Intercom", targets: ["Intercom"]),
  ],
  targets: [
    .target(
      name: "Intercom",
      dependencies: [])
  ]
)

