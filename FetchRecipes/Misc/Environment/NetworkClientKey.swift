//
//  NetworkClientKey.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation
import SwiftUI
import RecipesCore

struct NetworkClientKey: EnvironmentKey {
  static let defaultValue: NetworkClient = NetworkClientImpl(session: .shared, environment: .prod)
}
