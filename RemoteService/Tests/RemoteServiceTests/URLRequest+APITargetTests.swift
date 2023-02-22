//
//  URLRequest+APITargetTests.swift
//
//
//  Created by József Vesza on 2023. 05. 10..
//

import XCTest
import RemoteService

class URLRequest_APITargetTests: XCTestCase {
    var mockAPI: MockAPI!
    
    override func setUp() {
        mockAPI = MockAPI()
    }
    
    func testItParsesTheBaseURL() {
        // when
        let request = try? URLRequest(target: mockAPI)
        // then
        XCTAssertEqual(request?.url?.host, mockAPI.baseURL.absoluteString)
    }
    
    func testItParsesThePath() {
        // when
        let request = try? URLRequest(target: mockAPI)
        // then
        XCTAssertEqual(request?.url?.path, mockAPI.path)
    }
    
    func testItParsesTheHeaders() {
        // given
        let expectedHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        mockAPI.expectedHeaders = expectedHeaders
        // when
        let request = try? URLRequest(target: mockAPI)
        // then
        XCTAssertEqual(request?.allHTTPHeaderFields, expectedHeaders)
    }
    
    func testWhenInputIsGETRequest_ItSetsTheHttpMethodToGET() {
        // when
        let request = try? URLRequest(target: mockAPI)
        // then
        XCTAssertEqual(request?.httpMethod, "GET")
    }
    
    func testWhenInputIsPOSTRequest_ItSetsTheHttpMethodToPOST() {
        // given
        mockAPI.expectedAPIMethod = .post(data: "test")
        // when
        let request = try? URLRequest(target: mockAPI)
        // then
        XCTAssertEqual(request?.httpMethod, "POST")
    }
    
    func testWhenInputIsPOSTRequest_ItEncodesTheBody() {
        // given
        mockAPI.expectedAPIMethod = .post(data: "test")
        // when
        let request = try? URLRequest(target: mockAPI)
        // then
        guard let bodyData = request?.httpBody else {
            XCTFail("Failed to parse HTTP body")
            return
        }
        let body = try? JSONDecoder().decode(String.self, from: bodyData)
        XCTAssertEqual(body, "test")
    }
    
    func testWhenInputIsPUTRequest_ItSetsTheHttpMethodToPUT() {
        // given
        mockAPI.expectedAPIMethod = .put(data: "test")
        // when
        let request = try? URLRequest(target: mockAPI)
        // then
        XCTAssertEqual(request?.httpMethod, "PUT")
    }
    
    func testWhenInputIsPUTRequest_ItEncodesTheBody() {
        // given
        mockAPI.expectedAPIMethod = .put(data: "test")
        // when
        let request = try? URLRequest(target: mockAPI)
        // then
        guard let bodyData = request?.httpBody else {
            XCTFail("Failed to parse HTTP body")
            return
        }
        let body = try? JSONDecoder().decode(String.self, from: bodyData)
        XCTAssertEqual(body, "test")
    }
    
    func testWhenInputIsDELETERequest_ItSetsTheHttpMethodToDELETE() {
        // given
        mockAPI.expectedAPIMethod = .delete
        // when
        let request = try? URLRequest(target: mockAPI)
        // then
        XCTAssertEqual(request?.httpMethod, "DELETE")
    }
    
    func testWhenURLComponentsAreIncorrect_ItThrowsError() {
        // given
        mockAPI.expectedPath = "path"
        // when
        XCTAssertThrowsError(try URLRequest(target: mockAPI)) { error in
            // then
            let error = error as! URLRequest.RequestBuilderError
            guard case .incorrectURL = error else {
                XCTFail("Expected URLRequest.RequestBuilderError.incorrectURL")
                return
            }
        }
    }
    
    func testWhenEncodingTheBodyFails_ItThrowsError() {
        // given
        mockAPI.expectedAPIMethod = .post(data: Double.infinity)
        // when
        XCTAssertThrowsError(try URLRequest(target: mockAPI)) { error in
            // then
            let error = error as! URLRequest.RequestBuilderError
            guard case .dataEncoding = error else {
                XCTFail("Expected URLRequest.RequestBuilderError.dataEncoding")
                return
            }
        }
    }
}
