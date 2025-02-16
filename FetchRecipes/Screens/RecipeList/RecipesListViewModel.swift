//
//  RecipesListViewModel.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation
import RecipesCore
import SwiftUI

@Observable class RecipesListViewModel {
 
  var recipes: [Recipe] = []
  var filteredRecipes: [Recipe] = []
  var cuisines: [String] = []
  let networkClient: NetworkClient
  var currentFilter: Filter?
  var loadingState: LoadingState = .loading
  
  init(networkClient: NetworkClient) {
    recipes = []
    self.networkClient = networkClient
    
  }
  
  func refreshRecipes() async {
    loadingState = .loading
    do {
      let recipes = try await networkClient.get(request: AllRecipesEndpoint()).recipes
      
      await MainActor.run {
        self.loadingState = .success
        self.recipes = recipes
        self.filteredRecipes = recipes
        let cuisines: Set<String> = Set(recipes.map { $0.cuisine })
        self.cuisines = cuisines.sorted()
      }
    } catch {
      if let error = error as? NetworkClientError {
        loadingState = .error(error)
      } else {
        loadingState = .error(NetworkClientError.unknown)
      }
    }
  }
  
  func apply(filter: Filter?) {
    self.currentFilter = filter
    self.filteredRecipes = recipes.filter { filter?.cuisines.contains($0.cuisine) ?? true }
  }
}

enum LoadingState: Hashable {
  case loading
  case success
  case error(NetworkClientError)
}
