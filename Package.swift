// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSONAPIArbitrary",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "JSONAPIArbitrary",
            targets: ["JSONAPIArbitrary"]),
    ],
    dependencies: [
        .package(url: "https://github.com/typelift/SwiftCheck.git", .upToNextMinor(from: "0.12.0")),
        .package(url: "https://github.com/mattpolzin/JSONAPI.git", .upToNextMajor(from: "3.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
			name: "JSONAPIArbitrary",
			dependencies: ["JSONAPI", "SwiftCheck"]),
      .testTarget(
    name: "JSONAPIArbitraryTests",
    dependencies: ["JSONAPI", "SwiftCheck", "JSONAPIArbitrary"]),
    ],
    swiftLanguageVersions: [.v5]
)
