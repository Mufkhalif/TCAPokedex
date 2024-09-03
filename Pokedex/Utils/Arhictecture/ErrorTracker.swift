//
//  ErrorTracker.swift
//  Pokedex
//
//  Created by mufkhalif on 13/08/24.
//

import Combine

public typealias ErrorTracker = PassthroughSubject<Error?, Never>

public extension Publisher where Failure: Error {
    func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}
