//
//  AbilityResponse.swift
//  Pokedex
//
//  Created by mufkhalif on 02/09/24.
//

import Foundation

// MARK: - AbilityResponse

public struct AbilityResponse: Codable, Equatable {
  public static func == (lhs: AbilityResponse, rhs: AbilityResponse) -> Bool {
    return lhs.id == rhs.id
  }

  let effectChanges: [EffectChange]
  let effectEntries: [AbilityResponseEffectEntry]
  let flavorTextEntries: [FlavorTextEntry]
  let generation: Generation
  let id: Int
  let isMainSeries: Bool
  let name: String
  let names: [Name]
  let pokemon: [Pokemon]

  enum CodingKeys: String, CodingKey {
    case effectChanges = "effect_changes"
    case effectEntries = "effect_entries"
    case flavorTextEntries = "flavor_text_entries"
    case generation, id
    case isMainSeries = "is_main_series"
    case name, names, pokemon
  }
}

// MARK: - EffectChange

struct EffectChange: Codable {
  let effectEntries: [EffectChangeEffectEntry]
  let versionGroup: Generation

  enum CodingKeys: String, CodingKey {
    case effectEntries = "effect_entries"
    case versionGroup = "version_group"
  }
}

// MARK: - EffectChangeEffectEntry

struct EffectChangeEffectEntry: Codable {
  let effect: String
  let language: Generation
}

// MARK: - Generation

struct Generation: Codable {
  let name: String
  let url: String
}

// MARK: - AbilityResponseEffectEntry

struct AbilityResponseEffectEntry: Codable {
  let effect: String
  let language: Generation
  let shortEffect: String

  enum CodingKeys: String, CodingKey {
    case effect, language
    case shortEffect = "short_effect"
  }
}

// MARK: - FlavorTextEntry

struct FlavorTextEntry: Codable {
  let flavorText: String
  let language, versionGroup: Generation

  enum CodingKeys: String, CodingKey {
    case flavorText = "flavor_text"
    case language
    case versionGroup = "version_group"
  }
}

// MARK: - Name

struct Name: Codable {
  let language: Generation
  let name: String
}

// MARK: - Pokemon

struct Pokemon: Codable {
  let isHidden: Bool
  let pokemon: Generation
  let slot: Int

  enum CodingKeys: String, CodingKey {
    case isHidden = "is_hidden"
    case pokemon, slot
  }
}
