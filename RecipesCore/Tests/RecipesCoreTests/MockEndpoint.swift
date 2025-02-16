//
//  File 2.swift
//  
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation
@testable import RecipesCore

struct MockEndpoint: NetworkEndpoint {
  typealias Response = MockResponse
  
  var path: String = "recipes"
  var method: RecipesCore.HTTPMethod = .get
  var response: Response.Type = MockResponse.self 
}

struct MockResponse: Decodable {
  let uuid: UUID
  let name: String
  let email: String
}
