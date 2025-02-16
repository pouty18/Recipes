//
//  RecipesListEmptyView.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/20/25.
//

import Foundation
import SwiftUI

struct RecipesListEmptyView: View {
  
  var body: some View {
    List {
      Text("No recipes are available at this time")
    }
  }
}
