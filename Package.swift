// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sungorus",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "Sungorus",
            targets: [
                "Sungorus"
            ]
        ),
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Sungorus",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "SungorusTests",
            dependencies: [
                "Sungorus"
            ]
        ),
    ]
)
