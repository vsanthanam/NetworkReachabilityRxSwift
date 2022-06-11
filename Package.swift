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
        .package(url: "https://github.com/vsanthanam/NetworkReachability.git", branch: "main"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NetworkReachabilityRxSwift",
            dependencies: ["NetworkReachability", "RxSwift"]
        ),
        .testTarget(
            name: "NetworkReachabilityRxSwiftTests",
            dependencies: ["NetworkReachabilityRxSwift"]
        ),
    ]
)
