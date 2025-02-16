//
//  MockNetworkClient.swift
//  FetchRecipesTests
//
//  Created by Richard Poutier on 2/17/25.
//

import Foundation
@testable import RecipesCore

class MockNetworkClient: NetworkClient {
  var getHandler: ((any NetworkEndpoint) throws -> Decodable)!
  func get<E>(request: E) async throws -> E.Response where E : NetworkEndpoint {
    let mockedResponse = try getHandler(request)
    return mockedResponse as! E.Response
  }
}

