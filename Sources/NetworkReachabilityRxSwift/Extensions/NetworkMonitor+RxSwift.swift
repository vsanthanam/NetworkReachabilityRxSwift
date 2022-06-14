// NetworkReachabilityRxSwift
// NetworkMonitor+RxSwift.swift
//
// MIT License
//
// Copyright (c) 2021 Varun Santhanam
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
//
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED  AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Dispatch
import Foundation
import Network
import NetworkReachability
import RxSwift

/// RxSwift bindings for `NetworkMonitor`
@available(macOS 10.14, iOS 12.0, watchOS 5.0, tvOS 12.0, *)
public extension NetworkMonitor {

    /// An `Observable` of network path updates
    ///
    /// Use this property to observe network path updates using [RxSwift](https://github.com/ReactiveX/RxSwift)
    ///
    /// ```swift
    /// let disposable = NetworkMonitor.observableNetworkPath
    ///     .map { path in
    ///         path.status == .satisfied
    ///     }
    ///     .distinctUntilChanged()
    ///     .subscribe(onNext: { isSatisfied in
    ///         // Do something with `isSatisfied`
    ///     })
    /// ```
    static var observableNetworkPath: Observable<NWPath> {
        if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
            return Observable
                .create { observer in
                    let task = Task {
                        for await path in NetworkMonitor.networkPathUpdates {
                            observer.on(.next(path))
                        }
                        observer.on(.completed)
                    }
                    return Disposables.create {
                        task.cancel()
                    }
                }
        } else {
            return Observable
                .create { observer in
                    let queue = DispatchQueue.networkMonitorQueue
                    _ = NetworkMonitor { _, path in
                        queue.async {
                            observer.on(.next(path))
                        }
                    }
                    return Disposables.create()
                }
        }
    }

    /// An `Observable` of network path updates for a specific interface
    ///
    /// Use this property to observe network path updates using [RxSwift](https://github.com/ReactiveX/RxSwift)
    ///
    /// ```swift
    /// let disposable = NetworkMonitor.observableNetworkPath(requiringInterfaceType: .wifi)
    ///     .map { path in
    ///         path.status == .satisfied
    ///     }
    ///     .distinctUntilChanged()
    ///     .subscribe(onNext: { isSatisfied in
    ///         // Do something with `isSatisfied`
    ///     })
    /// ```
    static func observableNetworkPath(requiringInterfaceType interfaceType: NWInterface.InterfaceType) -> Observable<NWPath> {
        if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
            return Observable
                .create { observer in
                    let task = Task {
                        for await path in NetworkMonitor.networkPathUpdates(requiringInterfaceType: interfaceType) {
                            observer.on(.next(path))
                        }
                        observer.on(.completed)
                    }
                    return Disposables.create {
                        task.cancel()
                    }
                }
        } else {
            return Observable
                .create { observer in
                    let queue = DispatchQueue.networkMonitorQueue
                    _ = NetworkMonitor { _, path in
                        queue.async {
                            observer.on(.next(path))
                        }
                    }
                    return Disposables.create()
                }
        }
    }

    /// An `Observable` of network path updates for interface types that are not explicitly prohibited.
    ///
    /// Use this property to observe network path updates using [RxSwift](https://github.com/ReactiveX/RxSwift)
    ///
    /// ```swift
    /// let disposable = NetworkMonitor.observableNetworkPath(prohibitingInterfaceTypes: [.wifi, .wiredEthernet])
    ///     .map { path in
    ///         path.status == .satisfied
    ///     }
    ///     .distinctUntilChanged()
    ///     .subscribe(onNext: { isSatisfied in
    ///         // Do something with `isSatisfied`
    ///     })
    /// ```
    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    static func observableNetworkPath(prohibitingInterfaceTypes interfaceTypes: [NWInterface.InterfaceType]) -> Observable<NWPath> {
        Observable
            .create { observer in
                let task = Task {
                    for await path in NetworkMonitor.networkPathUpdates(prohibitingInterfaceTypes: interfaceTypes) {
                        observer.on(.next(path))
                    }
                    observer.on(.completed)
                }
                return Disposables.create {
                    task.cancel()
                }
            }
    }

    /// Retrieve the latest known network path using [RxSwift](https://github.com/ReactiveX/RxSwift)
    ///
    /// ```swift
    /// func updateReachability() {
    ///     _ = NetworkMonitor.singleNetworkPath
    ///         .subscribe(onNext: { path in
    ///             // Do something with `path`
    ///         })
    /// }
    /// ```
    static var singleNetworkPath: Single<NWPath> {
        Single.create { observer in
            if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
                let task = Task {
                    let path = await NetworkMonitor.networkPath
                    observer(.success(path))
                }
                return Disposables.create {
                    task.cancel()
                }
            } else {
                NetworkMonitor.networkPath { path in
                    observer(.success(path))
                }
                return Disposables.create()
            }
        }
    }
}
