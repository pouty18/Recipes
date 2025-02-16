//
//  SKWebView.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation
import WebKit
import SwiftUI
import UIKit

struct WebView: UIViewRepresentable {
  typealias UIViewType = WKWebView
  
  let url: URL
  
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    let request = URLRequest(url: url)
    uiView.load(request)
  }
}
