//
//  NetworkClient.swift
//  
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation

public protocol NetworkClient {
  // can scale to allow for other http methods
  func get<E: NetworkEndpoint>(request: E) async throws -> E.Response
}

public struct NetworkClientImpl: NetworkClient {
  private let session: URLSession
  private let environment: NetworkEnvironment
  
  public init(session: URLSession, environment:  NetworkEnvironment) {
    self.session = session
    self.environment = environment
  }
  
  public func get<E>(request: E) async throws -> E.Response where E : NetworkEndpoint {
    guard let url = self.getUrl(path: request.path) else {
      throw NetworkClientError.invalidUrlInitialization
    }
    let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
    do {
      let sessionTask = try await session.data(for: urlRequest)
      return try JSONDecoder().decode(E.Response.self, from: sessionTask.0)
    } catch _ as DecodingError {
      // decoding failed or the data task failed
      throw NetworkClientError.malformedResponse
    } catch {
      throw error
    }
  }
  
  // can be expanded to support QS params
  func getUrl(path: String) -> URL? {
    var components = URLComponents()
    components.scheme = environment.scheme
    components.host = environment.host
    components.path = path
    return components.url
  }
}
