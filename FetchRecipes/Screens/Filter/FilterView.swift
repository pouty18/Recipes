//
//  FilterView.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation
import SwiftUI

struct FilterView: View {
  
  let viewModel: FilterViewModel
  @State private var detent: PresentationDetent = .medium
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      List {
        Section("Cuisines") {
          ForEach(viewModel.cuisines, id: \.self) { cuisine in
            button(cuisine: cuisine, isSelected: viewModel.filteredCuisines.contains(cuisine))
          }
        }
      }.toolbar(.visible, for: .navigationBar)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Button("Clear") {
              withAnimation {
                viewModel.clearAllFilters()
              }
              dismiss()
            }
          }
          ToolbarItem(placement: .primaryAction) {
            Button("Apply") {
              withAnimation {
                viewModel.applyFilter()
              }
              dismiss()
            }
          }
        }
        .navigationTitle("Filters")
    } .presentationDragIndicator(.visible)
      .presentationDetents([.medium, .large], selection: $detent)

  }
  
  func button(cuisine: String, isSelected: Bool) -> some View {
    Button {
      viewModel.toggleFiltered(cuisine: cuisine)
    } label: {
      HStack {
        Text(cuisine)
        Spacer()
        Circle()
          .strokeBorder(Color.gray, style: .init(lineWidth: 1))
          .frame(width: 30, height: 30)
          .overlay {
            if viewModel.filteredCuisines.contains(cuisine) {
              Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
            }
          }
      }.contentShape(Rectangle())
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  Color.black
    .sheet(isPresented: .constant(true), content: {
      FilterView(viewModel: .init())
    })
  
}
