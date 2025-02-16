//
//  FCHMockURLProtocol.swift
//
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation

class FCHMockURLProtocol: URLProtocol {
  static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

  override class func canInit(with request: URLRequest) -> Bool {
    true
  }
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }
  override func startLoading() {
    guard let handler = FCHMockURLProtocol.requestHandler else {
      fatalError("Handler undefined")
    }
    do {
      let (response, data) = try handler(request)
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      client?.urlProtocol(self, didLoad: data)
      client?.urlProtocolDidFinishLoading(self)
    } catch {
      client?.urlProtocol(self, didFailWithError: error)
    }
  }
  override func stopLoading() {
    // unimplemented
  }
}
