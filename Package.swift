// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeedFeature",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FeedFeature",
            targets: ["FeedFeature"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/chinthaka01/PlatformKit.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/chinthaka01/DesignSystem.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FeedFeature",
            dependencies: [
                .product(name: "PlatformKit", package: "PlatformKit"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "FeedFeatureTests",
            dependencies: ["FeedFeature"]
        ),
    ]
)
