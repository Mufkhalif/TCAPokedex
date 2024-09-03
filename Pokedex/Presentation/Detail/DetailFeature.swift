//
//  DetailFeature.swift
//  Pokedex
//
//  Created by mufkhalif on 28/08/24.
//

import ComposableArchitecture
import Dependencies
import Foundation

@Reducer
struct DetailFeature {
  @ObservableState
  struct State: Equatable {
    var isLoading: Bool = false
    var errorMessage: String?
    var detail: DetailPokemonResponse?
    var ability: AbilityResponse?
    var paramsPokemon: PokemonDTO?
  }

  enum Action {
    case appear
    case detailFetched(
      Result<DetailPokemonResponse, AppError>
    )
    case abilityFetched(
      Result<AbilityResponse, AppError>
    )
    case closePage
  }

  @Dependency(\.pokemonClient) private var pokemonClient
  @Dependency(\.logger) private var logger

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .appear:
        state.isLoading = true
        return .run { [paramsPokemon = state.paramsPokemon] send in
          let response = await pokemonClient.fetchDetailPokemon(paramsPokemon?.id ?? "1")
          let responseAbility = await pokemonClient.fetchAbilityPokemon(paramsPokemon?.id ?? "1")
          await send(.detailFetched(response))
          await send(.abilityFetched(responseAbility))
        }
      case let .detailFetched(response):
        switch response {
        case let .success(data):
          state.detail = data
          state.isLoading = false
          return .none
        case let .failure(error):
          logger.error("Failed to load detail pokemon : \(error)")
          state.errorMessage = error.localizedDescription
          state.isLoading = false
          return .none
        }
      case .closePage:
        return .none
      case let .abilityFetched(response):
        switch response {
        case let .success(data):
          state.ability = data
          return .none
        case let .failure(error):
          logger.error("Failed to load ability pokemon : \(error)")
          state.errorMessage = error.localizedDescription
          state.isLoading = false
          return .none
        }
      }
    }
  }
}
