//
//  RecipeDetailViewModel.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation
import RecipesCore

@Observable class RecipeDetailViewModel {
  
  let recipe: Recipe
  let name: String
  let cuisine: String
  
  let photoUrlLarge: URL?
  let photoUrlSmall: URL?
  let sourceUrl: URL?
  let youtubeUrl: URL?
  
  init(recipe: Recipe) {
    self.recipe = recipe
    
    self.name = recipe.name
    self.cuisine = recipe.cuisine
    self.photoUrlLarge = recipe.photoUrlLarge
    self.photoUrlSmall = recipe.photoUrlSmall
    self.sourceUrl = recipe.sourceUrl
    self.youtubeUrl = recipe.youtubeUrl
  }
}
