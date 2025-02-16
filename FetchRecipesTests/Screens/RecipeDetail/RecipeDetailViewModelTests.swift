//
//  RecipeDetailViewModelTests.swift
//  FetchRecipesTests
//
//  Created by Richard Poutier on 2/17/25.
//

import XCTest
@testable import FetchRecipes
@testable import RecipesCore

final class RecipeDetailViewModelTests: XCTestCase {

  var subject: RecipeDetailViewModel!
  
  
  func testWhenInitThenCorrectPropertiesAreSet() {
    // GIVEN
    let recipe = Recipe(
      uuid: UUID(),
      cuisine: "American",
      name: "Cheeseburger",
      photoUrlLarge: URL(string: "https://picsum.photos/400"),
      photoUrlSmall: URL(string: "https://picsum.photos/100"),
      sourceUrl: URL(string: "https://picsum.photos"),
      youtubeUrl: URL(string: "https://www.youtube.com/watch?v=YMmgKCNcqwI"))
    
    // WHEN
    subject = RecipeDetailViewModel(recipe: recipe)
    
    // THEN
    XCTAssertEqual(subject.name, recipe.name)
    XCTAssertEqual(subject.cuisine, recipe.cuisine)
    XCTAssertEqual(subject.photoUrlLarge, recipe.photoUrlLarge)
    XCTAssertEqual(subject.photoUrlSmall, recipe.photoUrlSmall)
    XCTAssertEqual(subject.sourceUrl, recipe.sourceUrl)
    XCTAssertEqual(subject.youtubeUrl, recipe.youtubeUrl)
  }
}
