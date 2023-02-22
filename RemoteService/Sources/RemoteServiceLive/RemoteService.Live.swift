//
//  Live.swift
//
//
//  Created by József Vesza on 2023. 05. 10..
//

import Foundation
import Combine
import RemoteService

public extension RemoteService {
    static func live(session: URLSession = .shared) -> Self {
        Self(request: { target -> AnyPublisher<Data, RemoteServiceError> in
            do {
                let request = try URLRequest(target: target)
                return session
                    .dataTaskPublisher(for: request)
                    .tryMap { element -> Data in
                        guard let httpResponse = element.response as? HTTPURLResponse else {
                            throw RemoteServiceError.other(nil)
                        }
                        
                        guard httpResponse.statusCode >= 200,
                              httpResponse.statusCode < 300 else {
                            throw RemoteServiceError.badServerResponse(httpResponse.statusCode, element.data)
                        }
                        
                        return element.data
                    }
                    .mapError { error in
                        RemoteServiceError.other(error)
                    }
                    .eraseToAnyPublisher()
            } catch {
                return Fail<Data, RemoteServiceError>(error: RemoteServiceError.requestBuilder)
                    .eraseToAnyPublisher()
            }
        })
    }
}
