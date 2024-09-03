//
//  Font+Extention.swift
//  Pokedex
//
//  Created by mufkhalif on 08/08/24.
//

import SwiftUI

public extension Font {
  static func productSans(_ font: ProductSans, size: CGFloat) -> Font {
    return .custom(font.rawValue, size: size)
  }
}

public extension Font {
  enum Display {
    public static let xs = productSans(.bold, size: UIFontMetrics.default.scaledValue(for: 16))
    public static let s = productSans(.bold, size: UIFontMetrics.default.scaledValue(for: 32))
    public static let m = productSans(.bold, size: UIFontMetrics.default.scaledValue(for: 36))
    public static let l = productSans(.bold, size: UIFontMetrics.default.scaledValue(for: 40))
    public static let xl = productSans(.bold, size: UIFontMetrics.default.scaledValue(for: 44))
  }

  enum Paragraph {
    public static let xs = productSans(.regular, size: UIFontMetrics.default.scaledValue(for: 12))
    public static let s = productSans(.regular, size: UIFontMetrics.default.scaledValue(for: 14))
    public static let m = productSans(.regular, size: UIFontMetrics.default.scaledValue(for: 16))
    public static let l = productSans(.regular, size: UIFontMetrics.default.scaledValue(for: 18))
    public static let xl = productSans(.regular, size: UIFontMetrics.default.scaledValue(for: 20))
  }
}
