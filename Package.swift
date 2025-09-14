// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "JSONAPIArbitrary",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "JSONAPIArbitrary",
            targets: ["JSONAPIArbitrary"]),
    ],
    dependencies: [
        .package(url: "https://github.com/typelift/SwiftCheck.git", .upToNextMinor(from: "0.12.0")),
        .package(url: "https://github.com/mattpolzin/JSONAPI.git", from: "6.0.0"),
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
    swiftLanguageModes: [.v5,.v6]
)
