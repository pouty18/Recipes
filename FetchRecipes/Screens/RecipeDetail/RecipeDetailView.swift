//
//  RecipeDetailView.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation
import SwiftUI
import RecipesCore

struct RecipeDetailView: View {
  let viewModel: RecipeDetailViewModel
  
  var body: some View {
    VStack {
      if let url = viewModel.photoUrlLarge {
        CustomAsyncImage(url: url) { image in
          image
            .resizable()
            .aspectRatio(1, contentMode: .fit)
        } placeholder: {
          RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.secondary.opacity(0.5))
        }.ignoresSafeArea(.all, edges: .top)
          .overlay {
            VStack {
              Rectangle()
                .foregroundStyle(LinearGradient(stops: [.init(color: Color.black.opacity(0.5), location: 0), .init(color: Color.black.opacity(0), location: 1)], startPoint: .top, endPoint: .bottom))
                .frame(height: 150)
              Spacer()
            }.border(.green)
          }
          .ignoresSafeArea(.all, edges: .top)
      }
      cell(name: "Name:", value: viewModel.name)
      cell(name: "Cuisine:", value: viewModel.cuisine)
      if let youtubeUrl = viewModel.youtubeUrl {
        Link("View on Youtube", destination: youtubeUrl)
      }
      Spacer()
    }
  }
  
  @ViewBuilder
  func cell(name: String, value: String) -> some View {
    HStack {
      Text(name)
        .font(.body)
      Spacer()
      Text(value)
        .font(.headline)
    }
  }
}

#Preview {
  RecipeDetailView(viewModel: .init(recipe: .preview))
}
