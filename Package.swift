// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FontPicker",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "FontPicker",
            targets: ["FontPicker"]),
    ],
    dependencies: [
        .package(name: "HalfASheet", url: "https://github.com/franklynw/HalfASheet.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "FontPicker",
            dependencies: ["HalfASheet"]),
        .testTarget(
            name: "FontPickerTests",
            dependencies: ["FontPicker"]),
    ]
)
