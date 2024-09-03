// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonResponse = try? JSONDecoder().decode(PokemonResponse.self, from: jsonData)

import Foundation

// MARK: - PokemonResponse

public struct PokemonResponse: Codable {
  let count: Int
  let next: String
  let results: [PokemonDTO]

  init(count: Int, next: String, results: [PokemonDTO]) {
    self.count = count
    self.next = next
    self.results = results
  }
}

// MARK: - Result

public struct PokemonDTO: Codable {
  let name: String
  let url: String
  var id: String {
    if let pathUrl = URL(string: url) {
      let pathComponents = pathUrl.pathComponents
      if let id = pathComponents.last(where: { !$0.isEmpty }) {
        return id
      }
      return "0"
    }

    return "0"
  }
}

extension PokemonDTO: Equatable {
  public static func == (lhs: PokemonDTO, rhs: PokemonDTO) -> Bool {
    lhs.name == rhs.name
  }
}
