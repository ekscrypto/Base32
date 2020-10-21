// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Base32",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "Base32",
            targets: ["Base32"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Base32", dependencies: [], path: "Base32", exclude: ["main.m", "MF_AppDelegate.m"], sources: ["MF_Base32Additions.m"])
    ]
)
