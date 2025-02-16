//
//  NetworkEnvironment.swift
//  
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation

public enum NetworkEnvironment {
  case prod
  case test
  
  // defaulting prod/test to same properties
  // can be expanded to support multi-environment
  var scheme: String {
    switch self {
      case .prod:
        return "https"
      case .test:
        return "https"
    }
  }
  var host: String {
    switch self {
      case .prod:
        return "d3jbb8n5wk0qxi.cloudfront.net"
      case .test:
        return "d3jbb8n5wk0qxi.cloudfront.net"
    }
  }
}
