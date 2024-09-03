//
//  PokemonClient.swift
//  Pokedex
//
//  Created by mufkhalif on 27/08/24.
//

import Dependencies
import Foundation

public extension DependencyValues {
  var pokemonClient: PokemonClient {
    get { self[PokemonClient.self] }
    set { self[PokemonClient.self] = newValue }
  }
}

public struct PokemonClient {
  private init() {}

  public func fetchPokemons() async -> Result<PokemonResponse, AppError> {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "pokeapi.co"
    components.path = "/api/v2/pokemon"
    components.queryItems = [
      URLQueryItem(name: "limit", value: "100"),
    ]

    guard let url = components.url else {
      return .failure(.networkError(URLError(.badURL)))
    }

    return await URLSession.shared.get(url: url, decodeResponseAs: PokemonResponse.self)
  }

  public func fetchDetailPokemon(_ id: String) async -> Result<DetailPokemonResponse, AppError> {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "pokeapi.co"
    components.path = "/api/v2/pokemon/\(id)"

    guard let url = components.url else {
      return .failure(.networkError(URLError(.badURL)))
    }

    return await URLSession.shared.get(url: url, decodeResponseAs: DetailPokemonResponse.self)
  }

  public func fetchAbilityPokemon(_ id: String) async -> Result<AbilityResponse, AppError> {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "pokeapi.co"
    components.path = "/api/v2/ability/\(id)"

    guard let url = components.url else {
      return .failure(.networkError(URLError(.badURL)))
    }

    return await URLSession.shared.get(url: url, decodeResponseAs: AbilityResponse.self)
  }
}

extension PokemonClient: DependencyKey {
  public static var liveValue = PokemonClient()
}
