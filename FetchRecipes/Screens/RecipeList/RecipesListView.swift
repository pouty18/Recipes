//
//  RecipesListView.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation
import SwiftUI
import RecipesCore

enum RecipeViewStyle: Hashable {
  case list
  case grid
  case malformedData
  case empty
}

struct RecipesListView: View {
  
  var viewModel: RecipesListViewModel
  @State private var navigationPath: NavigationPath = .init()
  @State private var viewStyle: RecipeViewStyle = .grid
  @State private var presentedItem: PresentableItem? = .none
  
  private enum PresentableItem: String, Identifiable, Hashable {
    case filterView
    case settings
    
    var id: String { self.rawValue }
  }
  
  var body: some View {
    NavigationStack(path: $navigationPath) {
      ZStack {
        switch viewModel.loadingState {
          case .loading:
            EmptyView()
          case .success:
            content
          case .error(let error):
            errorView(error: error)
        }
      }
      .navigationTitle("Recipes")
      .task {
        await viewModel.refreshRecipes()
      }
      .sheet(item: $presentedItem, content: { item in
        switch item {
          case .filterView:
            FilterView(viewModel: FilterViewModel(cuisines: viewModel.cuisines, existingFilter: viewModel.currentFilter, onApply: viewModel.apply))
          case .settings:
            SettingsView(viewStyle: $viewStyle)
        }
      })
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button(action: {
            Task {
              print("refreshing")
              await viewModel.refreshRecipes()
            }
          }, label: {
            Image(systemName: "arrow.clockwise")
          })
        }
        ToolbarItem(placement: .topBarTrailing) {
          Button(action: {
            presentedItem = .filterView
          }, label: {
            Image(systemName: "line.3.horizontal.decrease")
          })
        }
        
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            presentedItem = .settings
          }, label: {
            Image(systemName: "gear")
          })
        }
      }
    }
  }
  
  
  @ViewBuilder
  var content: some View {
    switch viewStyle {
      case .list:
        list
      case .grid:
        grid
      case .malformedData:
        IssueWithServerView {
          Task { await viewModel.refreshRecipes() }
        }
      case .empty:
        RecipesListEmptyView()
    }
  }
  
  @ViewBuilder
  func errorView(error: NetworkClientError) -> some View {
    switch error {
      case .malformedResponse, .invalidUrlInitialization, .unknown:
        IssueWithServerView {
          Task {
            await viewModel.refreshRecipes()
          }
        }
    }
  }
  
  @ViewBuilder
  var grid: some View {
    if viewModel.recipes.isEmpty {
      RecipesListEmptyView()
    } else {
      ScrollView {
        LazyVGrid(
          columns: [GridItem(.adaptive(minimum: 150, maximum: 250), spacing: 20, alignment: .top)],
          alignment: .trailing,
          content: {
            ForEach(viewModel.filteredRecipes) { recipe in
              NavigationLink {
                RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: recipe))
              } label: {
                RecipeCellView(
                  imageUrlSmall: recipe.photoUrlSmall,
                  imageUrlLarge: recipe.photoUrlLarge,
                  name: recipe.name,
                  cuisine: recipe.cuisine,
                  style: .card)
              }.buttonStyle(.plain)
            }
          })
        .padding()
      }
    }
  }
  
  @ViewBuilder
  var list: some View {
    if viewModel.recipes.isEmpty {
     RecipesListEmptyView()
    } else {
      List {
        Section {
          ForEach(viewModel.filteredRecipes) { recipe in
            NavigationLink {
              RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: recipe))
            } label: {
              RecipeCellView(
                imageUrlSmall: recipe.photoUrlSmall,
                imageUrlLarge: recipe.photoUrlLarge,
                name: recipe.name,
                cuisine: recipe.cuisine)
            }
          }
        }
      }
      .clipped()
      .listStyle(.plain)
    }
  }
}

#Preview {
  RecipesListView(
    viewModel: .init(networkClient: NetworkClientImpl(session: .shared, environment: .test)))
}
