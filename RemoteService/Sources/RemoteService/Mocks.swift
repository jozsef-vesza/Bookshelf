//
//  Mocks.swift
//  
//
//  Created by József Vesza on 2023. 05. 10..
//

import Foundation
import Combine

public extension RemoteService {
    static func mockedDataResponse<T: APITarget>(data: [String: Data], targetReader: ((T) -> Void)? = nil) -> RemoteService<T> {
        RemoteService<T> { target in
            targetReader?(target)
            
            let data = data[target.path] ?? Data()
            
            return Just(data)
                .setFailureType(to: RemoteServiceError.self)
                .eraseToAnyPublisher()
        }
    }
    
    static func mockedErrorResponse<T: APITarget>(error: RemoteServiceError) -> RemoteService<T> {
        RemoteService<T> { _ in
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
