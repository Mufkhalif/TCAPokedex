//
//  SlidingTabView.swift
//  Pokedex
//
//  Created by mufkhalif on 28/08/24.
//

import SwiftUI

public struct SlidingTabView: View {
  // MARK: Internal State

  /// Internal state to keep track of the selection index
  @State private var selectionState: Int = 0 {
    didSet {
      selection = selectionState
    }
  }

  // MARK: Required Properties

  /// Binding the selection index which will  re-render the consuming view
  @Binding var selection: Int

  /// The title of the tabs
  let tabs: [String]

  // MARK: View Customization Properties

  /// The font of the tab title
  let font: Font

  /// The selection bar sliding animation type
  let animation: Animation

  /// The accent color when the tab is selected
  let activeAccentColor: Color

  /// The accent color when the tab is not selected
  let inactiveAccentColor: Color

  /// The color of the selection bar
  let selectionBarColor: Color

  /// The tab color when the tab is not selected
  let inactiveTabColor: Color

  /// The tab color when the tab is  selected
  let activeTabColor: Color

  /// The height of the selection bar
  let selectionBarHeight: CGFloat

  /// The selection bar background color
  let selectionBarBackgroundColor: Color

  /// The height of the selection bar background
  let selectionBarBackgroundHeight: CGFloat

  // MARK: init

  public init(selection: Binding<Int>,
              tabs: [String],
              font: Font = .body,
              animation: Animation = .spring(),
              activeAccentColor: Color = .blue,
              inactiveAccentColor: Color = Color.black.opacity(0.4),
              selectionBarColor: Color = .blue,
              inactiveTabColor: Color = .clear,
              activeTabColor: Color = .clear,
              selectionBarHeight: CGFloat = 2,
              selectionBarBackgroundColor: Color = Color.gray.opacity(0.2),
              selectionBarBackgroundHeight: CGFloat = 1)
  {
    _selection = selection
    self.tabs = tabs
    self.font = font
    self.animation = animation
    self.activeAccentColor = activeAccentColor
    self.inactiveAccentColor = inactiveAccentColor
    self.selectionBarColor = selectionBarColor
    self.inactiveTabColor = inactiveTabColor
    self.activeTabColor = activeTabColor
    self.selectionBarHeight = selectionBarHeight
    self.selectionBarBackgroundColor = selectionBarBackgroundColor
    self.selectionBarBackgroundHeight = selectionBarBackgroundHeight
  }

  // MARK: View Construction

  public var body: some View {
    assert(tabs.count > 1, "Must have at least 2 tabs")

    return VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: 0) {
        ForEach(self.tabs, id: \.self) { tab in
          Button(action: {
            let selection = self.tabs.firstIndex(of: tab) ?? 0
            self.selectionState = selection
          }) {
            HStack {
              Spacer()
              Text(tab).font(.Display.xs)
              Spacer()
            }
          }
          .padding(.vertical, 16)
          .accentColor(
            self.isSelected(tabIdentifier: tab)
              ? self.activeAccentColor
              : self.inactiveAccentColor)
          .background(
            self.isSelected(tabIdentifier: tab)
              ? self.activeTabColor
              : self.inactiveTabColor)
        }
      }
      GeometryReader { geometry in
        ZStack(alignment: .leading) {
          Rectangle()
            .fill(self.selectionBarColor)
            .frame(width: self.tabWidth(from: geometry.size.width), height: self.selectionBarHeight, alignment: .leading)
            .offset(x: self.selectionBarXOffset(from: geometry.size.width), y: 0)
            .animation(self.animation)
          Rectangle()
            .fill(self.selectionBarBackgroundColor)
            .frame(width: geometry.size.width, height: self.selectionBarBackgroundHeight, alignment: .leading)
        }.fixedSize(horizontal: false, vertical: true)
      }.fixedSize(horizontal: false, vertical: true)
    }
  }

  // MARK: Private Helper

  private func isSelected(tabIdentifier: String) -> Bool {
    return tabs[selectionState] == tabIdentifier
  }

  private func selectionBarXOffset(from totalWidth: CGFloat) -> CGFloat {
    return tabWidth(from: totalWidth) * CGFloat(selectionState)
  }

  private func tabWidth(from totalWidth: CGFloat) -> CGFloat {
    return totalWidth / CGFloat(tabs.count)
  }
}

struct SlidingTabConsumerView: View {
  @State private var selectedTabIndex = 0

  var body: some View {
    VStack(alignment: .leading) {
      SlidingTabView(
        selection: self.$selectedTabIndex,
        tabs: ["First", "Second"],
        font: .body,
        activeAccentColor: Color.blue,
        selectionBarColor: Color.blue
      )
      (selectedTabIndex == 0 ? Text("First View") : Text("Second View")).padding()
      Spacer()
    }
    .padding(.top, 50)
  }
}

#Preview {
  SlidingTabConsumerView()
}
