//
//  FetchRecipesApp.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import SwiftUI
import RecipesCore

// Since an app instance is launched during SwiftUI lifecycle, we capture this and redirect it to a
// test app where we can ensure we properly setup all our mocks. This methodology is referenced
// in the following article https://qualitycoding.org/bypass-swiftui-app-launch-unit-testing/

@main
struct MainEntryPoint {
  static func main() {
    guard isProduction() else {
      TestApp.main()
      return
    }
    
    FetchRecipesApp.main()
  }
  
  private static func isProduction() -> Bool {
    return NSClassFromString("XCTestCase") == nil
  }
}


struct TestApp: App {
  var body: some Scene {
    WindowGroup {
      Text("Hello")
    }
  }
}

struct FetchRecipesApp: App {
  @Environment(\.networkClient) var networkClient
  var body: some Scene {
    WindowGroup {
      RecipesListView(viewModel: RecipesListViewModel(networkClient: networkClient))
    }
  }
}

