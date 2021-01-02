// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CombineSemantics",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "CombineSemantics",
            targets: ["CombineSemantics"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CombineSemantics",
            dependencies: []
        ),
        .testTarget(
            name: "CombineSemanticsTests",
            dependencies: ["CombineSemantics"],
            exclude: ["CombineSemanticsTests.swift.gyb"]
        ),
    ]
)
