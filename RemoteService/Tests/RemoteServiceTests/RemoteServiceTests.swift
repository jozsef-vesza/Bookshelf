//
//  RemoteServiceTests.swift
//
//
//  Created by József Vesza on 2023. 05. 10..
//

import XCTest
import Combine
import RemoteService
import RemoteServiceLive

class RemoteServiceTests: XCTestCase {
    var mockAPI: MockAPI!
    var sut: RemoteService<MockAPI>!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        mockAPI = MockAPI()
        mockAPI.expectedPath = ""
        sut = RemoteService.live(session: session)
    }
    
    override func tearDown() {
        URLProtocolMock.failingURLs = []
        URLProtocolMock.testURLs = [:]
        cancellables = []
    }
    
    func testWhenLoadingSucceeds_ItEmitsTheResponseData() {
        // given
        let url = URL(string: "https://www.apple.com")!
        let expectation = XCTestExpectation(description: "Loading successful")
        
        let expectedData =
            """
            {
                "id" : "test"
            }
            """.data(using: .utf8)!
        
        URLProtocolMock.testURLs = [url: expectedData]
        
        // when
        sut
            .request(mockAPI)
            .sink(receiveCompletion: { _ in }) { receivedData in
                // then
                XCTAssertEqual(receivedData, expectedData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenBuildingTheURL_ItIncludesProvidedParameters() {
        class MockAPIWithParameters: MockAPI {
            override var requestType: RequestType {
                return .withParameters(parameters: ["page_size": "15"])
            }
            override var path: String {
                return ""
            }
        }
        
        // given
        let url = URL(string: "https://www.apple.com?page_size=15")!
        let expectation = XCTestExpectation(description: "Loading successful")
        mockAPI = MockAPIWithParameters()
        
        let expectedData =
            """
            {
                "id" : "test"
            }
            """.data(using: .utf8)!
        
        URLProtocolMock.testURLs = [url: expectedData]
        
        // when
        sut
            .request(mockAPI)
            .sink(receiveCompletion: { _ in }) { receivedData in
                // then
                XCTAssertEqual(receivedData, expectedData)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenLoadingFails_ItEmitsTheWrappedError() {
        // given
        let url = URL(string: "https://www.apple.com")!
        let expectation = XCTestExpectation(description: "Loading failed")
        
        URLProtocolMock.failingURLs = [url]
        
        // when
        sut
            .request(mockAPI)
            .sink(receiveCompletion: { completion in
                guard case .failure = completion else {
                    XCTFail("Expected call to fail")
                    return
                }
                expectation.fulfill()
            }) { _ in }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenBuildingTheURLRequestFails_ItEmitsTheWrappedRequestBuilderError() {
        // given
        mockAPI.expectedPath = "failingPath"
        let expectation = XCTestExpectation(description: "Loading failed")
        
        // when
        sut
            .request(mockAPI)
            .sink(receiveCompletion: { completion in
                guard case .failure(let receivedError) = completion,
                      case .requestBuilder = receivedError else {
                          XCTFail("Expected RemoteServiceError.requestBuilder")
                          return
                      }
                expectation.fulfill()
            }) { _ in }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

}
