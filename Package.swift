// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ImageSugar",
    platforms: [.iOS(.v12), .macOS(.v10_13)],
    products: [
        .library(
            name: "ImageSugar",
            targets: ["ImageSugar"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ImageSugar",
            dependencies: [])
    ]
)
