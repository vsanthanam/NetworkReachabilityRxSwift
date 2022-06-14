// NetworkReachabilityRxSwift
// ReachabilityMonitor+RxSwift.swift
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

import Darwin
import Foundation
import NetworkReachability
import RxSwift

/// RxSwift bindings for `ReachabilityMonitor`
@available(macOS 10.13, iOS 11, watchOS 4, tvOS 11, *)
public extension ReachabilityMonitor {

    /// An `Observable` of reachability updates
    ///
    /// Use this property to observe reachability updates with [RxSwift](https://github.com/ReactiveX/RxSwift).
    ///
    /// ```swift
    /// let disposable = ReachabilityMonitor.observableReachability
    ///     .map(\.status.isReachable)
    ///     .distinctUntilChanged()
    ///     .subscribe(onNext: { isReachable in
    ///         // Do something with `isReachable`
    ///     }, onError: { error in
    ///         // Handle error
    ///     })
    /// ```
    static var observableReachability: Observable<Reachability> {
        if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
            return Observable
                .create { observer in
                    let task = Task {
                        do {
                            for try await reachability in ReachabilityMonitor.reachabilityUpdates {
                                observer.on(.next(reachability))
                            }
                            observer.on(.completed)
                        } catch {
                            observer.on(.error(error))
                        }
                    }
                    return Disposables.create {
                        task.cancel()
                    }
                }
        } else {
            return Observable
                .create { observer in
                    let queue = DispatchQueue.reachabilityMonitorQueue
                    do {
                        _ = try ReachabilityMonitor { _, result in
                            do {
                                let reachability = try result.get()
                                queue.async {
                                    observer.on(.next(reachability))
                                }
                            } catch {
                                queue.async {
                                    observer.on(.error(error))
                                }
                            }
                        }
                    } catch {
                        queue.async {
                            observer.on(.error(error))
                        }
                    }
                    return Disposables.create()
                }
        }
    }

    /// An `Observable` of reachability updates for a specific host
    ///
    /// Use this property to observe reachability updates with [RxSwift](https://github.com/ReactiveX/RxSwift).
    ///
    /// ```swift
    /// let disposable = ReachabilityMonitor.observableReachability(forHost: "www.apple.com")
    ///     .map(\.status.isReachable)
    ///     .distinctUntilChanged()
    ///     .subscribe(onNext: { isReachable in
    ///         // Do something with `isReachable`
    ///     }, onError: { error in
    ///         // Handle error
    ///     })
    /// ```
    static func observableReachability(forHost host: String) -> Observable<Reachability> {
        if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
            return Observable
                .create { observer in
                    let task = Task {
                        do {
                            for try await reachability in ReachabilityMonitor.reachabilityUpdates(forHost: host) {
                                observer.on(.next(reachability))
                            }
                            observer.on(.completed)
                        } catch {
                            observer.on(.error(error))
                        }
                    }
                    return Disposables.create {
                        task.cancel()
                    }
                }
        } else {
            return Observable
                .create { observer in
                    let queue = DispatchQueue.reachabilityMonitorQueue
                    do {
                        _ = try ReachabilityMonitor(host: host) { _, result in
                            do {
                                let reachability = try result.get()
                                queue.async {
                                    observer.on(.next(reachability))
                                }
                            } catch {
                                queue.async {
                                    observer.on(.error(error))
                                }
                            }
                        }
                    } catch {
                        queue.async {
                            observer.on(.error(error))
                        }
                    }
                    return Disposables.create()
                }
        }
    }

    /// An `Observable` of reachability updates for a specific socket address
    ///
    /// Use this property to observe reachability updates with [RxSwift](https://github.com/ReactiveX/RxSwift).
    ///
    /// ```swift
    /// let disposable = ReachabilityMonitor.observableReachability(forAddress: myAddress)
    ///     .map(\.status.isReachable)
    ///     .distinctUntilChanged()
    ///     .subscribe(onNext: { isReachable in
    ///         // Do something with `isReachable`
    ///     }, onError: { error in
    ///         // Handle error
    ///     })
    /// ```
    static func observableReachability(forAddress address: sockaddr) -> Observable<Reachability> {
        if #available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) {
            return Observable
                .create { observer in
                    let task = Task {
                        do {
                            for try await reachability in ReachabilityMonitor.reachabilityUpdates(forAddress: address) {
                                observer.on(.next(reachability))
                            }
                            observer.on(.completed)
                        } catch {
                            observer.on(.error(error))
                        }
                    }
                    return Disposables.create {
                        task.cancel()
                    }
                }
        } else {
            return Observable
                .create { observer in
                    let queue = DispatchQueue.reachabilityMonitorQueue
                    do {
                        _ = try ReachabilityMonitor(address: address) { _, result in
                            do {
                                let reachability = try result.get()
                                queue.async {
                                    observer.on(.next(reachability))
                                }
                            } catch {
                                queue.async {
                                    observer.on(.error(error))
                                }
                            }
                        }
                    } catch {
                        queue.async {
                            observer.on(.error(error))
                        }
                    }
                    return Disposables.create()
                }
        }
    }

    /// A `Single` of reachability updates
    ///
    /// Use this property to retrieve the latest reachability with [RxSwift](https://github.com/ReactiveX/RxSwift).
    ///
    /// ```swift
    /// let disposable = ReachabilityMonitor.singleReachability
    ///     .map(\.status.isReachable)
    ///     .subscribe(onSuccess: { isReachable in
    ///         // Do something with `isReachable`
    ///     }, onFailure: { error in
    ///         // Handle error
    ///     })
    /// ```
    static var singleReachability: Single<Reachability> {
        Single.create { observer in
            do {
                let reachability = try ReachabilityMonitor.reachability
                observer(.success(reachability))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }

}
