//
//  HomeFeature.swift
//  Pokedex
//
//  Created by mufkhalif on 27/08/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct HomeFeature {
  @Dependency(\.pokemonClient) private var pokemonClient
  @Dependency(\.logger) private var logger

  @ObservableState
  struct State: Equatable {
    var pokemons: [PokemonDTO] = []
    var isLoading: Bool = false
    var errorMessage: String?

    @Presents var detailFeat: DetailFeature.State?
  }

  enum Action {
    case onAppear
    case pokemonListFetched(
      Result<PokemonResponse, AppError>
    )
    case onOpendetail(PokemonDTO)
    case onGetDetail(PresentationAction<DetailFeature.Action>)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.isLoading = true
        return .run { send in
          let lastUpdated = await pokemonClient.fetchPokemons()
          await send(.pokemonListFetched(lastUpdated))
        }
      case let .pokemonListFetched(result):
        switch result {
        case let .success(response):
          logger.info(
            "Success Fetching Pokemons list: \(response)",
            context: ["keypath": "pokemons"]
          )
          state.pokemons = response.results
          state.errorMessage = nil
          state.isLoading = false
          return .none
        case let .failure(error):
          logger.error(
            "Failed to load Pokemons list: \(error)",
            context: ["keypath": "pokemons"]
          )
          state.errorMessage = error.localizedDescription
          state.isLoading = false
          return .none
        }
      case let .onOpendetail(pokemon):
        state.detailFeat = DetailFeature.State(
          paramsPokemon: pokemon
        )
        print("Hellooo")
        return .none
      case .onGetDetail(.presented(.detailFetched)):
        return .none
      case .onGetDetail(.dismiss):
        return .none
      case .onGetDetail(.presented(.appear)):
        return .none
      case .onGetDetail(.presented(.closePage)):
        state.detailFeat = nil
        return .none
      case .onGetDetail(.presented(.abilityFetched(_))):
        return .none
      }
    }
    .ifLet(\.$detailFeat, action: \.onGetDetail) {
      DetailFeature()
    }
  }
}
