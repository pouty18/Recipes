//
//  RecipeListViewModelTests.swift
//  FetchRecipesTests
//
//  Created by Richard Poutier on 2/17/25.
//

import XCTest
@testable import FetchRecipes
@testable import RecipesCore

final class RecipeListViewModelTests: XCTestCase {

  var subject: RecipesListViewModel!
  var mockRecipes: [Recipe] {
    [
      Recipe(uuid: UUID(), cuisine: "American", name: "Cheeseburger", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
      Recipe(uuid: UUID(), cuisine: "American", name: "Hot Dog", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
      Recipe(uuid: UUID(), cuisine: "French", name: "Bananna & Nutella Crêpe", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
      Recipe(uuid: UUID(), cuisine: "Italian", name: "Rigatoni Alla Vodka", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
    ]
  }
  
  func testWhenRefreshIsCalledThenTheRecipesAreSet() async {
    // GIVEN
    let mockClient = MockNetworkClient()
    subject = RecipesListViewModel(networkClient: mockClient)
    mockClient.getHandler = { _ in
      RecipeContainer(recipes: self.mockRecipes)
    }
    
    // WHEN
    await subject.refreshRecipes()
    
    // THEN
    XCTAssertFalse(subject.filteredRecipes.isEmpty)
    XCTAssertFalse(subject.recipes.isEmpty)
    let expectedCuisines: Set<String> = Set(mockRecipes.map { $0.cuisine })
    XCTAssertEqual(subject.cuisines, expectedCuisines.sorted())
    XCTAssertEqual(subject.loadingState, .success)
  }
  
  func testWhenAFilterIsAppliedToNoRecipesThenTheFilteredRecipesIsEmpty() {
    // GIVEN
    let filter = Filter(cuisines: ["cuisine1", "cuisine2", "cuisine3"])
    subject = RecipesListViewModel(networkClient: MockNetworkClient())
    
    // WHEN
    subject.apply(filter: filter)
    
    // THEN
    XCTAssertEqual(subject.currentFilter, filter)
    XCTAssertTrue(subject.filteredRecipes.isEmpty)
  }
  
  func testWhenAFilterIsAppliedToRecipesThenTheFilteredRecipesCorrectlyReflectsFilter() async {
    // GIVEN
    let filter = Filter(cuisines: ["cuisine1", "cuisine2", "cuisine3"])
    let mockNetworkClient = MockNetworkClient()
    subject = RecipesListViewModel(networkClient: mockNetworkClient)
    
    mockNetworkClient.getHandler = { _ in
      RecipeContainer(recipes: self.mockRecipes)
    }
    
    // WHEN
    
    subject.apply(filter: filter)
    
    // THEN
    XCTAssertEqual(subject.currentFilter, filter)
    XCTAssertTrue(subject.filteredRecipes.isEmpty)
  }
  
  func testWhenRefreshIsCalledThenLoadingStateCorrectlyChangesToSuccessState() async {
    // GIVEN
    let mockClient = MockNetworkClient()
    subject = RecipesListViewModel(networkClient: mockClient)
    mockClient.getHandler = { _ in
      RecipeContainer(recipes: self.mockRecipes)
    }
    XCTAssertEqual(subject.loadingState, .loading)
    
    // WHEN
    await subject.refreshRecipes()
    
    // THEN
    XCTAssertEqual(subject.loadingState, .success)
    
  }
  
  func testWhenRefreshIsCalledThenLoadingStateCorrectlyChangesToErrorState() async {
    // GIVEN
    let mockClient = MockNetworkClient()
    subject = RecipesListViewModel(networkClient: mockClient)
    mockClient.getHandler = { _ in
      throw NetworkClientError.malformedResponse
    }
    XCTAssertEqual(subject.loadingState, .loading)
    
    // WHEN
    await subject.refreshRecipes()
    
    // THEN
    XCTAssertEqual(subject.loadingState, .error(.malformedResponse))
    
  }
}
