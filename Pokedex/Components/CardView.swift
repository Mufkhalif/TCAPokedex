//
//  CardView.swift
//  Pokedex
//
//  Created by mufkhalif on 29/08/24.
//

import Kingfisher
import SwiftUI

struct CardView: View {
  let item: PokemonDTO

  var body: some View {
    VStack(alignment: .leading) {
      Text(item.name.capitalized)
        .font(.Display.xs)
        .foregroundColor(.black)
      HStack {
        Spacer()
        KFImage(url(item.id))
          .resizable()
          .frame(width: 90, height: 90)
          .background(
            Image("pokeball")
              .resizable()
              .frame(width: 90, height: 90)
              .padding(.trailing, 16)
              .opacity(0.07)
              .offset(x: 20)
          )
      }
      Spacer()
    }
    .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
    .padding()
    .background(Color.white)
    .cornerRadius(16)
    .foregroundColor(.white)
    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
  }
}

extension CardView {
  func url(_ id: String) -> URL? {
    let urlPrefix = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
    return URL(string: "\(urlPrefix)\(id).png")
  }
}
