//
//  RecipeCellView.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation
import SwiftUI
import RecipesCore

struct RecipeCellView: View {
  enum CellStyle {
    case card
    case cell
  }
  
  let imageUrlSmall: URL?
  let imageUrlLarge: URL?
  let name: String
  let cuisine: String
  let style: CellStyle
  
  @State private var retry: Bool = false
  
  init(imageUrlSmall: URL?, imageUrlLarge: URL?, name: String, cuisine: String, style: CellStyle = .cell) {
    self.imageUrlSmall = imageUrlSmall
    self.imageUrlLarge = imageUrlLarge
    self.name = name
    self.cuisine = cuisine
    self.style = style
  }
  
  var body: some View {
    let _ = Self._printChanges()
    switch style {
      case .card:
        cardView
      case .cell:
        cellView
    }
  }
  
  @ViewBuilder
  var cardView: some View {
    VStack(alignment: .leading) {
      if let url = imageUrlLarge {
        CustomAsyncImage(url: url) { image in
          image
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .aspectRatio(contentMode: .fit)
        } placeholder: {
          RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(.gray.opacity(0.25))
        }
      }
//      CacheAsyncImage(url: imageUrlSmall, transaction: Transaction()) { phase in
//        switch phase {
//          case .empty:
//            RoundedRectangle(cornerRadius: 8)
//              .foregroundStyle(.gray.opacity(0.25))
//          case .success(let image):
//            image
//              .resizable()
//              .aspectRatio(1, contentMode: .fit)
//              .aspectRatio(contentMode: .fit)
//          case .failure(let error):
//            Button("Retry") {
//              print("retry: \(error)")
//              if let url = imageUrlLarge {
//                ImageCache[url] = nil
//              }
//              retry.toggle()
//              
//            }.buttonStyle(.borderedProminent)
//          @unknown default:
//            RoundedRectangle(cornerRadius: 8)
//              .foregroundStyle(.gray.opacity(0.25))
//        }
//      }
      
//      CacheAsyncImage(url: imageUrlLarge) { image in
//        image
//          .resizable()
//          .aspectRatio(1, contentMode: .fit)
//          .aspectRatio(contentMode: .fit)
//      } placeholder: {
//        RoundedRectangle(cornerRadius: 8)
//          .foregroundStyle(.gray.opacity(0.25))
//      }

      VStack(alignment: .leading) {
        Text(name)
          .foregroundStyle(.primary)
          .font(.headline)
          .multilineTextAlignment(.leading)
          .lineLimit(3)
        Text(cuisine)
          .font(.body)
          .foregroundStyle(.secondary)
      }
    }
    .frame(maxWidth: 200)
  }
  
  @ViewBuilder
  var cellView: some View {
    HStack {
      if let url = imageUrlLarge {
        CustomAsyncImage(url: url) { image in
          image
            .resizable()
            .frame(width: 40, height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
          RoundedRectangle(cornerRadius: 8)
            .frame(width: 40, height: 40)
        }
      }
      VStack(alignment: .leading) {
        Text(name)
          .font(.body)
          .foregroundStyle(.primary)
        Text(cuisine)
          .font(.caption)
          .foregroundStyle(.secondary)
      }
      Spacer()
    }
  }
}

#Preview {
  VStack {
//    RecipeCellView(
//      imageUrlSmall: URL(string: "https://picsum.photos/100"),
//      imageUrlLarge: URL(string: "https://picsum.photos/400"),
//      name: "Chicken Parm",
//      cuisine: "Italian")
    RecipeCellView(
      imageUrlSmall: URL(string: "https://picsum.photos/100"),
      imageUrlLarge: URL(string: "https://picsum.photos/400"),
      name: Recipe.preview.name,
      cuisine: Recipe.preview.cuisine,
      style: .card)
  }
}
