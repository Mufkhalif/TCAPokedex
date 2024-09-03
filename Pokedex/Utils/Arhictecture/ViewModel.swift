//
//  ViewModel.swift
//  Pokedex
//
//  Created by mufkhalif on 13/08/24.
//

import Combine
import Foundation
import Then

public protocol ViewModel: Then {
  associatedtype Input
  associatedtype Output

  func transform(_ input: Input, cancelBag: Cancellable) -> Output
}
