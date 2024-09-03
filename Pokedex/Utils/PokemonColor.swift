//
//  File.swift
//  Pokedex
//
//  Created by mufkhalif on 02/09/24.
//

import Foundation
import SwiftUI

let grass = Color(red: 0.31, green: 0.76, blue: 0.65)
let fire = Color(red: 0.97, green: 0.47, blue: 0.42)
let water = Color(red: 0.35, green: 0.67, blue: 0.96)
let electric = Color(red: 1.0, green: 0.81, blue: 0.29)
let dark = Color(red: 0.49, green: 0.33, blue: 0.55)
let stone = Color(red: 0.69, green: 0.45, blue: 0.42)

public func findColorPokemon(name: String) -> Color {
  switch name.lowercased() {
  case "grass":
    return grass
  case "fire":
    return fire
  case "electric":
    return electric
  case "stone", "normal", "bug", "ground":
    return stone
  case "dark", "poison":
    return dark
  case "water":
    return water
  default:
    return water
  }
}

let greenStat = Color(red: 0.28, green: 0.82, blue: 0.69) // 0xff48D0B0
let darkStat = Color(red: 0.17, green: 0.2, blue: 0.24) // 0xff2B333E
let redStat = Color(red: 0.98, green: 0.42, blue: 0.42) // 0xffFB6C6C
let blueStat = Color(red: 0.43, green: 0.71, blue: 0.97) // 0xff6EB4F9
let darkBlueStat = Color(red: 0.04, green: 0.29, blue: 0.91) // 0xff094BE8
let subtitleStat = Color(red: 0.69, green: 0.69, blue: 0.69) // 0xffAFAFAF
let brownStat = Color(red: 0.81, green: 0.61, blue: 0.28) // 0xffCF9B48
let purpleStat = Color(red: 0.56, green: 0.53, blue: 0.9) // 0xff9087E5

struct StateColor {
  let name: String
  let color: Color

  static func findColor(name: String) -> StateColor {
    return listColor.first { $0.name == name } ?? listColor[0]
  }
}

let listColor = [
  StateColor(name: "hp", color: greenStat),
  StateColor(name: "attack", color: blueStat),
  StateColor(name: "defense", color: darkBlueStat),
  StateColor(name: "special-attack", color: brownStat),
  StateColor(name: "special-defense", color: purpleStat),
  StateColor(name: "speed", color: redStat),
]
