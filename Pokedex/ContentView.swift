//
//  ContentView.swift
//  Pokedex
//
//  Created by mufkhalif on 02/09/24.
//

import ComposableArchitecture
import SwiftUI
import UIPilot

enum AppRoute: Equatable {
  case home
  case detail(_ pokemon: PokemonDTO)
}

struct ContentView: View {
  @StateObject var pilot = UIPilot(initial: AppRoute.home)

  var body: some View {
    UIPilotHost(pilot) { route in
      switch route {
      case .home:
        HomeView(
          store: Store(initialState: HomeFeature.State()) {
            HomeFeature()
          }
        )
      case let .detail(pokemon): DetailView(
          store: Store(initialState: DetailFeature.State(paramsPokemon: pokemon)) {
            DetailFeature()
          }
        )
      }
    }
  }
}

#Preview {
  ContentView()
}
