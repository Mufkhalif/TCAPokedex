//
//  Combine+Rx.swift
//  Pokedex
//
//  Created by mufkhalif on 13/08/24.
//

import Combine
import Foundation

public typealias Driver<T> = AnyPublisher<T, Never>
public typealias Observable<T> = AnyPublisher<T, Error>
public typealias PublishRelay<T> = PassthroughSubject<T, Never>
public typealias BehaviorRelay<T> = CurrentValueSubject<T, Never>

// MARK: - Driver

public extension Publisher {
    func asDriver() -> Driver<Output> {
        return self.catch { _ in Empty() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> Driver<Output> {
        return Just(output).eraseToAnyPublisher()
    }

    static func empty() -> Driver<Output> {
        return Empty().eraseToAnyPublisher()
    }
}

// MARK: - Observable

public extension Publisher {
    func asObservable() -> Observable<Output> {
        mapError { $0 }
            .eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> Observable<Output> {
        Just(output)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    static func empty() -> Observable<Output> {
        return Empty().eraseToAnyPublisher()
    }
}
