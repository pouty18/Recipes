//
//  Environment+ext.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation
import SwiftUI
import RecipesCore

extension EnvironmentValues {
  var networkClient: NetworkClient {
    self[NetworkClientKey.self]
  }
}
