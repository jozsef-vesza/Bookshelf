//
//  URLProtocolMock.swift
//
//
//  Created by József Vesza on 2023. 05. 10..
//

import Foundation
import XCTest

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()
    static var failingURLs = [URL]()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let client = client else { return }
        guard let url = request.url else {
            client.urlProtocolDidFinishLoading(self)
            return
        }
        
        do {
            if URLProtocolMock.failingURLs.contains(url) {
                let response = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil))
                client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client.urlProtocol(self, didFailWithError: NSError(domain: "Error", code: -1, userInfo: nil))
            } else {
                let response = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil))
                client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                if let data = URLProtocolMock.testURLs[url] {
                    client.urlProtocol(self, didLoad: data)
                }
            }
        } catch {
            client.urlProtocol(self, didFailWithError: error)
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
