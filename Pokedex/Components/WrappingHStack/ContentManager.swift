//
//  ContentManager.swift
//  Pokedex
//
//  Created by mufkhalif on 29/08/24.
//

import Foundation
import SwiftUI

class ContentManager {
  let items: [ViewType]
  let getWidths: () -> [Double]
  lazy var widths: [Double] = getWidths()

  init(items: [ViewType], getWidths: @escaping () -> [Double]) {
    self.items = items
    self.getWidths = getWidths
  }

  func isVisible(viewIndex: Int) -> Bool {
    widths[viewIndex] > 0
  }
}

enum ViewType {
  case any(AnyView)
  case newLine

  init<V: View>(rawView: V) {
    switch rawView {
    case is NewLine: self = .newLine
    default: self = .any(AnyView(rawView))
    }
  }
}

public struct NewLine: View {
  public init() {}
  public let body = Spacer(minLength: .infinity)
}
