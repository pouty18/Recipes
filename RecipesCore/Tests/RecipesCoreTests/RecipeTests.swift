//
//  RecipeTests.swift
//  
//
//  Created by Richard Poutier on 2/16/25.
//

import XCTest
import RecipesCore

final class RecipeTests: XCTestCase {

  func testSerialization() {
    // GIVEN
    let jsonString = """
{
            "cuisine": "British",
            "name": "Bakewell Tart",
            "photo_url_large": "https://some.url/large.jpg",
            "photo_url_small": "https://some.url/small.jpg",
            "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
            "source_url": "https://some.url/index.html",
            "youtube_url": "https://www.youtube.com/watch?v=some.id"
        }
"""
    guard let jsonData = jsonString.data(using: .utf8) else { return XCTFail("Invalid JSON Provided") }
    
    // WHEN
    do {
      let recipe = try JSONDecoder().decode(Recipe.self, from: jsonData)
      
      // THEN
      XCTAssertEqual(recipe.cuisine, "British")
      XCTAssertEqual(recipe.name, "Bakewell Tart")
      XCTAssertEqual(recipe.photoUrlLarge?.absoluteString, "https://some.url/large.jpg")
      XCTAssertEqual(recipe.photoUrlSmall?.absoluteString, "https://some.url/small.jpg")
      XCTAssertEqual(recipe.uuid.uuidString.lowercased(), "eed6005f-f8c8-451f-98d0-4088e2b40eb6".lowercased())
      XCTAssertEqual(recipe.sourceUrl?.absoluteString, "https://some.url/index.html")
      XCTAssertEqual(recipe.youtubeUrl?.absoluteString, "https://www.youtube.com/watch?v=some.id")
    } catch {
      XCTFail("Invalid serialization")
    }
  }
    
}
