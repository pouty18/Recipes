//
//  FilterViewModel.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation
import RecipesCore

@Observable class FilterViewModel {
  var cuisines: [String] = []
  var filteredCuisines: Set<String> = []
  
  var onApply: ((Filter?) -> Void)
  
  #if DEBUG
  init() {
    cuisines = ["American", "Italian", "Greek", "French", "Japanase", "Brazilian", "Mexian", "German", "Chinese", "Polish", "Hawaiian"]
    onApply = { _ in }
  }
  #endif
  
  init(cuisines: [String], existingFilter: Filter?, onApply: @escaping (Filter?) -> Void) {
    self.cuisines = cuisines
    self.filteredCuisines = Set(existingFilter?.cuisines ?? [])
    self.onApply = onApply
  }
  
  func toggleFiltered(cuisine: String) {
    if filteredCuisines.contains(cuisine) {
      filteredCuisines.remove(cuisine)
    } else {
      filteredCuisines.insert(cuisine)
    }
  }
  
  func clearAllFilters() {
    filteredCuisines.removeAll()
    onApply(nil)
  }
  
  func applyFilter() {
    let filter = Filter(cuisines: Array(filteredCuisines))
    onApply(filter)
  }
}

struct Filter: Equatable {
  var cuisines: [String]
}
