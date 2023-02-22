//
//  Interface.swift
//
//
//  Created by József Vesza on 2023. 05. 10..
//

import Foundation
import Combine

public struct RemoteService<Target: APITarget> {
    public let request: (Target) -> AnyPublisher<Data, RemoteServiceError>
    
    public init(request: @escaping (Target) -> AnyPublisher<Data, RemoteServiceError>) {
        self.request = request
    }
}

public enum RemoteServiceError: Error {
    case requestBuilder
    case badServerResponse(_ statusCode: Int, _ data: Data)
    case other(Error?)
}
