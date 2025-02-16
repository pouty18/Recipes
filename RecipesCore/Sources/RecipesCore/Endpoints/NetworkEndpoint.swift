//
//  NetworkEndpoint.swift
//  
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation

public protocol NetworkEndpoint {
  associatedtype Response: Decodable
 
  // can also add properties for POST body type, parameters, auth, etc.
  var path: String { get }
  var method: HTTPMethod { get }
  var response: Response.Type { get }
}
