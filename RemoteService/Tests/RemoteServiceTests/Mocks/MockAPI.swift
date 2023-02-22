//
//  MockAPI.swift
//  
//
//  Created by József Vesza on 2023. 05. 10..
//

import Foundation
import RemoteService

class MockAPI: APITarget {
    var expectedBaseURL: URL = URL(string: "www.apple.com")!
    var baseURL: URL { return expectedBaseURL }
    
    var expectedPath: String = "/path"
    var path: String { return expectedPath }
    
    var expectedAPIMethod = APIMethod.get
    var method: APIMethod {
        return expectedAPIMethod
    }
    
    var requestType: RequestType {
        return .plain
    }
    
    var expectedHeaders: [String: String] = [:]
    var headers: [String: String]? {
        return expectedHeaders
    }
}
