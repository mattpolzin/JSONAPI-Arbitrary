// swift-tools-version:5.2

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
        .package(url: "https://github.com/typelift/SwiftCheck", .upToNextMinor(from: "0.12.0")),
        .package(url: "https://github.com/mattpolzin/JSONAPI", from: "4.0.0-alpha.3.2"),
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
