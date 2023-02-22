//
//  APITarget.swift
//  
//
//  Created by József Vesza on 2023. 05. 10..
//

import Foundation

public protocol APITarget {
    var baseURL: URL { get }
    var path: String { get }
    var method: APIMethod { get }
    var headers: [String: String]? { get }
    var requestType: RequestType { get }
}
