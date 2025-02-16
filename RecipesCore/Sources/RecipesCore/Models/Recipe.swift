//
//  Recipe.swift
//
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation

public struct RecipeContainer: Decodable {
  public let recipes: [Recipe]
}

public struct Recipe: DomainModel {
  public var id: UUID { uuid }
  public let uuid: UUID
  public let cuisine: String
  public let name: String
  public let photoUrlLarge: URL?
  public let photoUrlSmall: URL?
  public let sourceUrl: URL?
  public let youtubeUrl: URL?
  
  enum CodingKeys: String, CodingKey {
    case uuid
    case cuisine
    case name
    case photoUrlLarge = "photo_url_large"
    case photoUrlSmall = "photo_url_small"
    case sourceUrl = "source_url"
    case youtubeUrl = "youtube_url"
  }
  
#if DEBUG
  // provide initializer for SwiftUI previews
  public static var preview: Recipe {
    Recipe(
      uuid: UUID(),
      cuisine: "French",
      name: "White Chocolate Crème Brûlée",
      photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/large.jpg"),
      photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/small.jpg"),
      sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/2540/white-chocolate-crme-brle"),
      youtubeUrl: URL(string: "https://www.youtube.com/watch?v=LmJ0lsPLHDc"))
  }
#endif
}

