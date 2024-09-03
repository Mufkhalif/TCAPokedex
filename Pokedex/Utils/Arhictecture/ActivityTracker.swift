//
//  ActivityTracker.swift
//  Pokedex
//
//  Created by mufkhalif on 13/08/24.
//

import Combine
import Foundation

final class ActivityTracker: ObservableObject {
  @Published private var loadingCount: Int = 0

  var isLoading: AnyPublisher<Bool, Never> {
    $loadingCount
      .map { $0 > 0 }
      .removeDuplicates()
      .eraseToAnyPublisher()
  }

  private func increment() {
    loadingCount += 1
  }

  private func decrement() {
    loadingCount -= 1
  }

  func trackActivity<P: Publisher>(_ source: P) -> AnyPublisher<P.Output, P.Failure> {
    source
      .handleEvents(receiveSubscription: { _ in self.increment() },
                    receiveCompletion: { _ in self.decrement() },
                    receiveCancel: { self.decrement() })
      .eraseToAnyPublisher()
  }
}

extension Publisher {
  func trackActivity(_ activityIndicator: ActivityTracker) -> AnyPublisher<Output, Failure> {
    activityIndicator.trackActivity(self)
  }
}
