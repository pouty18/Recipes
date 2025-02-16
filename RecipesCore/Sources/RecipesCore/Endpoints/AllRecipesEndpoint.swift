//
//  AllRecipesEndpoint.swift
//
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation

public struct AllRecipesEndpoint: NetworkEndpoint {
  public typealias Response = RecipeContainer
  
  public var path: String {
    // valid path
    "/recipes.json"
    // malformed path
//        "/recipes-malformed.json"
    // empty path
//        "/recipes-empty.json"
  }
  public var method: HTTPMethod { .get }
  public var response: Response.Type { RecipeContainer.self }
  
  public init() { }
}
