//
//  AllRecipesEndpointTests.swift
//  
//
//  Created by Richard Poutier on 2/16/25.
//

import XCTest
@testable import RecipesCore

final class AllRecipesEndpointTests: XCTestCase {

  func testProperties() {
    // GIVEN
    let subject = AllRecipesEndpoint()
    
    // WHEN
    // TheN
    XCTAssertEqual(subject.path, "/recipes.json")
    XCTAssertEqual(subject.method, .get)
  }
  
  func testExpectedResponseIsMappedIntoARecipeContainer() async throws {
    // GIVEN
    let jsonData = """
{
    "recipes": [
        {
            "cuisine": "British",
            "name": "Bakewell Tart",
            "photo_url_large": "https://some.url/large.jpg",
            "photo_url_small": "https://some.url/small.jpg",
            "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
            "source_url": "https://some.url/index.html",
            "youtube_url": "https://www.youtube.com/watch?v=some.id"
        }
    ]
}
""".data(using: .utf8)!
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [FCHMockURLProtocol.self]
    let session = URLSession(configuration: config)
    let networkClient = NetworkClientImpl(session: session, environment: .test)
    FCHMockURLProtocol.requestHandler = { _ in
        (HTTPURLResponse(), jsonData)
    }
    // WHEN
    let response = try await networkClient.get(request: AllRecipesEndpoint())
    
    // THEN
    XCTAssertEqual(response.recipes.count, 1)
  }
  
}
