// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkReachabilityRxSwift",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "NetworkReachabilityRxSwift",
            targets: ["NetworkReachabilityRxSwift"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/vsanthanam/NetworkReachability.git", from: "1.1.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0")
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
