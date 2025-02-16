//
//  File 2.swift
//  
//
//  Created by Richard Poutier on 2/16/25.
//

import Foundation
import XCTest
@testable import RecipesCore

final class NetworkClientTests: XCTestCase {

  var subject: NetworkClient!
  
  override func setUp() async throws {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [FCHMockURLProtocol.self]
    let session = URLSession(configuration: config)
    subject = NetworkClientImpl(session: session, environment: .test)
  }
  
  func testWhenGetIsCalledThenItCorrectlyDecodesTheResponse() async throws {
    // GIVEN
    let validJsonData = """
{
  "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
  "name": "Jim",
  "email": "jim@gmail.com"
}
""".data(using: .utf8)!
    let endpoint = MockEndpoint()
    FCHMockURLProtocol.requestHandler = { request in
        return (HTTPURLResponse(), validJsonData)
    }
    
    // WHEN
    let response = try await subject.get(request: endpoint)
    
    // THEN
    XCTAssertEqual(response.uuid.uuidString.lowercased(), "eed6005f-f8c8-451f-98d0-4088e2b40eb6")
    XCTAssertEqual(response.name, "Jim")
    XCTAssertEqual(response.email, "jim@gmail.com")
  }
 
  func testWhenGetIsCalledThenItThrowsMalformedResponseIfJsonIsBad() async throws {
    // GIVEN
    let validJsonData = """
{
  "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
  "name": "Jim",
  "email": 1234
}
""".data(using: .utf8)!
    let endpoint = MockEndpoint()
    FCHMockURLProtocol.requestHandler = { request in
        return (HTTPURLResponse(), validJsonData)
    }
    
    // WHEN
    do {
      let _ = try await subject.get(request: endpoint)
      XCTFail("Exception should be thrown on malformed data")
    } catch {
    
      // THEN
      XCTAssertEqual(error as? NetworkClientError, NetworkClientError.malformedResponse)
    }
  }
}

