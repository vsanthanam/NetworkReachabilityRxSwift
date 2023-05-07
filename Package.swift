// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkReachabilityRxSwift",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11),
        .watchOS(.v5)
    ],
    products: [
        .library(
            name: "NetworkReachabilityRxSwift",
            targets: ["NetworkReachabilityRxSwift"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/vsanthanam/NetworkReachability.git", from: "1.2.1"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", exact: "0.51.7")
    ],
    targets: [
        .target(
            name: "NetworkReachabilityRxSwift",
            dependencies: ["NetworkReachability", "RxSwift"]
        ),
        .testTarget(
            name: "NetworkReachabilityRxSwiftTests",
            dependencies: ["NetworkReachabilityRxSwift", "NetworkReachability", "RxSwift"]
        ),
    ]
)
