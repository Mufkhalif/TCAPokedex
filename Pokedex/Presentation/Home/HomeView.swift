//
//  HomeView.swift
//  Pokedex
//
//  Created by mufkhalif on 13/08/24.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI
import UIPilot

struct HomeView: View {
  @Bindable var store: StoreOf<HomeFeature>
  @EnvironmentObject var appPilot: UIPilot<AppRoute>

  let items = Array(1 ... 10)

  let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16),
  ]

  @State private var showDetail = false

  var body: some View {
    ZStack(alignment: .top) {
      overlayBackground
      if store.isLoading {
        Text("Loading ...")
          .font(.Paragraph.xl)
          .padding(.top, 80)
      } else {
        VStack {
          HStack {
            Text("Pokedex")
              .font(.Display.m)
            Spacer()
          }
          .frame(maxWidth: .infinity)
          ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 16) {
              ForEach(store.pokemons, id: \.self.name) { item in
                CardView(item: item)
                  .onTapGesture {
                    appPilot.push(.detail(item))
                  }
              }
            }
          }
        }
      }
    }
    .background(Color.white)
    .padding()
    .onAppear {
      store.send(.onAppear)
    }
  }

  @ViewBuilder
  private var overlayBackground: some View {
    HStack {
      Spacer()
      Image("pokeball")
        .resizable()
        .frame(width: 200, height: 200)
        .padding(.trailing, 16)
        .offset(x: 60, y: -80)
        .opacity(0.1)
    }
  }
}

#Preview {
  HomeView(
    store: Store(initialState: HomeFeature.State()) {
      HomeFeature()
    }
  )
}
