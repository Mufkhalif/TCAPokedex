//
//  DetailHome.swift
//  Pokedex
//
//  Created by mufkhalif on 28/08/24.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI
import UIPilot

struct DetailView: View {
  let store: StoreOf<DetailFeature>
  @EnvironmentObject var appPilot: UIPilot<AppRoute>

  @State var isActive: Bool = false
  @State private var showCloseButton: Bool = false
  @State private var selectedTabIndex = 0

  var body: some View {
    NavigationStack {
      ZStack(alignment: .topLeading) {
        backgroundCover

        ScrollView { coverContent }
          .sheet(isPresented: .constant(true)) { infoPokemonContent }
      }
    }
    .onAppear {
      store.send(.appear)
    }
    .ignoresSafeArea()
//    .navigationBarBackButtonHidden(true)
//    .toolbar {
//      ToolbarItem(placement: .topBarLeading) {
//        Button(action: {
//          appPilot.pop()
//          print("Get Back")
//        }, label: {
//          Image(systemName: "xmark.circle.fill")
//            .resizable()
//            .foregroundStyle(Color.white)
//            .frame(width: 25, height: 25)
//            .padding([.top, .trailing], 25)
//
//        })
//      }
  }

  @ViewBuilder
  private var backgroundCover: some View {
    Group {
      Rectangle()
        .foregroundColor(getBaseColor())

      RoundedRectangle(cornerRadius: 24)
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [
              Color.white.opacity(0.4),
              Color.white.opacity(0.1),
            ]),
            startPoint: .top,
            endPoint: .bottom
          )
        )
        .frame(width: 140, height: 140)
        .rotationEffect(.degrees(-10))
        .position(x: 80, y: 60)

      GeometryReader { geometry in
        Image("dotted")
          .resizable()
          .frame(width: 171, height: 91)
          .opacity(0.4)
          .position(x: geometry.size.width - 60, y: 125)
      }
    }
  }

  @ViewBuilder
  private var infoPokemonContent: some View {
    VStack(alignment: .leading) {
      SlidingTabView(
        selection: self.$selectedTabIndex,
        tabs: ["About", "Base State", "Move"],
        activeAccentColor: Color.black
      )

      if selectedTabIndex == 0 {
        aboutContent
      } else if selectedTabIndex == 1 {
        baseStateContent
      } else {
        moveContent
      }

      Spacer()
    }
    .padding()
    .presentationDetents([.fraction(0.45), .fraction(1)])
    .interactiveDismissDisabled()
  }

  @ViewBuilder
  private var coverContent: some View {
    VStack(alignment: .leading) {
      Text(store.paramsPokemon?.name ?? "Load ...")
        .font(.Display.m)
        .foregroundStyle(Color.white)
        .padding(.top, 20)

      KFImage(url(store.paramsPokemon?.id ?? "1"))
        .resizable()
        .frame(width: 240, height: 240)
        .background(
          Image("pokeball")
            .resizable()
            .frame(width: 200, height: 200)
            .opacity(0.3)
        )
        .frame(maxWidth: .infinity, alignment: .center)
    }
    .padding(.top, 60)
    .padding(.leading, 20)
  }

  @ViewBuilder
  private var aboutContent: some View {
    VStack(alignment: .leading) {
      if store.ability != nil && !(store.ability?.effectEntries ?? []).isEmpty {
        Text(store.ability?.effectEntries[1].effect ?? "")
          .font(.Paragraph.m)
          .padding(.top, 12)
      }

      HStack(alignment: .center) {
        Spacer()
        VStack(spacing: 12) {
          Text("Height")
            .font(.Paragraph.s)
            .foregroundStyle(.secondary)

          Text("\(store.detail?.height ?? 0)")
            .font(.Display.s)
        }

        Spacer()
        VStack(spacing: 12) {
          Text("Weight")
            .font(.Paragraph.s)
            .foregroundStyle(.secondary)

          Text("\(store.detail?.weight ?? 0)")
            .font(.Display.s)
        }

        Spacer()

        VStack(spacing: 12) {
          Text("Experience")
            .font(.Paragraph.s)
            .foregroundStyle(.secondary)

          Text("\(store.detail?.baseExperience ?? 0)")
            .font(.Display.s)
        }
        Spacer()
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding()
      .padding(.horizontal, 12)
      .background(Color.white)
      .cornerRadius(10)
      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
      .padding(.top, 12)
    }
  }

  @ViewBuilder
  private var baseStateContent: some View {
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(store.detail?.stats ?? []) { item in
          VStack(alignment: .leading) {
            Text(item.stat.name.capitalized)
              .font(.Paragraph.m)
            ProgressView(value: Double(item.baseStat) / 100)
              .cornerRadius(20)
              .frame(height: 12)
              .padding(.bottom, 24)
          }
          .tint(StateColor.findColor(name: item.stat.name).color)
        }
      }
      .padding(.top, 12)
    }
  }

  private func getBaseColor() -> Color {
    if store.isLoading && store.detail == nil {
      return Color.defaultGreen
    } else {
      return findColorPokemon(name: store.detail?.types[0].type.name ?? "")
    }
  }

  @ViewBuilder
  private var moveContent: some View {
    VStack(alignment: .leading) {
      WrappingHStack(lineSpacing: 12) {
        _buildItemMove("Jumping")
        _buildItemMove("Running")
        _buildItemMove("Shoot")
      }
    }
  }

  @ViewBuilder
  private func _buildItemMove(_ move: String) -> some View {
    HStack(spacing: 4) {
      Text(move).font(.Paragraph.m)
    }
    .padding(.vertical, 8)
    .padding(.horizontal, 16)
    .foregroundColor(.white)
    .background(getBaseColor())
    .cornerRadius(20)
    .overlay(
      RoundedRectangle(cornerRadius: 20)
        .stroke(getBaseColor(), lineWidth: 1.5)
    )
  }
}

extension DetailView {
  func url(_ id: String) -> URL? {
    let urlPrefix = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
    return URL(string: "\(urlPrefix)\(id).png")
  }
}

#Preview {
  DetailView(
    store: Store(initialState: DetailFeature.State(
      paramsPokemon: PokemonDTO(name: "Baldaur", url: "https://pokeapi.co/api/v2/pokemon/18/")
    )) {
      DetailFeature()
    }
  )
}

struct Tag: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.white)
      .frame(maxWidth: 144)
      .fixedSize()
      .padding(.horizontal, 12)
      .padding(.vertical, 4)
      .background(Color.blue)
      .cornerRadius(64)
  }
}
