//
//  APIMethod.swift
//  
//
//  Created by József Vesza on 2023. 05. 10..
//

import Foundation

public enum APIMethod {
    case get
    case post(data: Encodable?)
    case put(data: Encodable)
    case delete
}
