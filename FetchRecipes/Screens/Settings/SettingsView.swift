//
//  SettingsView.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation
import SwiftUI

struct SettingsView: View {
  @Binding var viewStyle: RecipeViewStyle
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      List {
        Section("View Settings") {
          picker
            .listRowSeparator(.hidden)
            .aspectRatio(contentMode: .fill)
            .listRowInsets(EdgeInsets())
            .listSectionSpacing(.default)
        }
      }
      .navigationTitle("Settings")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Close") {
            dismiss()
          }
        }
      }
      .presentationDetents([.medium])
    }
    .presentationDetents([.medium])
  }
  
  var picker: some View {
    Picker(selection: $viewStyle, content: {
      Text("Grid")
        .tag(RecipeViewStyle.grid)
      Text("List")
        .tag(RecipeViewStyle.list)
      Text("Malformed Data")
        .tag(RecipeViewStyle.malformedData)
      Text("Empty")
        .tag(RecipeViewStyle.empty)
    }, label: {
      Text("Recipe View Style")
    })
    .pickerStyle(.automatic)
    .padding(.horizontal)
  }

}

#Preview {
  @State var viewStyle: RecipeViewStyle = .grid
  return Color.white
    .sheet(isPresented: .constant(true), content: {
      SettingsView(viewStyle: $viewStyle)
    })
}
