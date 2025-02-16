//
//  IssueWithServerView.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/19/25.
//

import Foundation
import SwiftUI

struct IssueWithServerView: View {
  
  var tryAgainAction: () -> Void
  
  var body: some View {
    VStack(spacing: 12) {
      Text("We seem to be experiencing an issue with our server. We value your patience as we work to resolve this issue. It may take up to a few hours to fix. If the issue persists past that, please feel free to reach out to support.")
      HStack {
        Button("Try Again") {
          tryAgainAction()
        }
        .foregroundStyle(.blue.opacity(0.5))
        Spacer()
        Link(destination: URL(string: "https://help.fetch.com/hc/en-us/requests/new")!) {
          Text("Contact Support")
        }.foregroundStyle(.red)
          .font(.headline)
      }
      Spacer()
    }.padding()
  }
}

#Preview {
  ZStack {
    Color.black
    IssueWithServerView() { }
  }
}
