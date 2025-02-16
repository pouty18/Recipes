//
//  RecipeClientError.swift
//  
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation

public enum NetworkClientError: Error {
  case invalidUrlInitialization
  case malformedResponse
  case unknown
}
