# NetworkReachabilityRxSwift

[![MIT License](https://img.shields.io/github/license/vsanthanam/NetworkReachabilityRxSwift)](https://github.com/vsanthanam/AnyAsyncSequence/blob/main/LICENSE)
[![Package Releases](https://img.shields.io/github/v/release/vsanthanam/NetworkReachabilityRxSwift)](https://github.com/vsanthanam/NetworkReachabilityRxSwift/releases)
[![Build Results](https://img.shields.io/github/actions/workflow/status/vsanthanam/NetworkReachabilityRxSwift/spm-build-test.yml)](https://github.com/vsanthanam/NetworkReachability/actions/workflows/spm-build-test.yml)
[![Swift Version](https://img.shields.io/badge/swift-5.8-critical)](https://swift.org)
[![Supported Platforms](https://img.shields.io/badge/platform-iOS%2011%20%7C%20macOS%2010.13%20%7C%20tvOS%2011%20%7C%20watchOS%205-lightgrey)](https://developer.apple.com)

[RxSwift](https://github.com/ReactiveX/RxSwift) bindings for [NetworkReachability](https://github.com/vsanthanam/NetworkReachability)

## Installation

NetworkReachabilityRxSwift is currently distributed exclusively through the [Swift Package Manager](https://www.swift.org/package-manager/). 

To add NetworkReachabilityRxSwift as a dependency to an existing Swift package, add the following line of code to the `dependencies` parameter of your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/vsanthanam/NetworkReachability.git", from: "1.0.0")),
    .package(url: "https://github.com/vsanthanam/NetworkReachabilityRxSwift.git", from: "1.0.0"))
]
```

To add NetworkReachabilityRxSwift as a dependency to an Xcode Project: 

- Choose `File` → `Add Packages...`
- Enter package URL `https://github.com/vsanthanam/NetworkReachabilityRxSwift.git` and select your release and of choice.

Other distribution mechanisms like CocoaPods or Carthage may be added in the future.

Additional installation instructions are available on the [Swift Package Index](https://swiftpackageindex.com/vsanthanam/NetworkReachabilityRxSwift)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fvsanthanam%2FNetworkReachabilityRxSwift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/vsanthanam/NetworkReachabilityRxSwift)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fvsanthanam%2FNetworkReachabilityRxSwift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/vsanthanam/NetworkReachabilityRxSwift)

Explore [the documentation](https://vsanthanam.github.io/NetworkReachabilityRxSwift/docs/documentation/networkreachabilityrxswift/) for more details.

## License

**NetworkReachabilityRxSwift** is available under the MIT license. See the LICENSE file for more information.
