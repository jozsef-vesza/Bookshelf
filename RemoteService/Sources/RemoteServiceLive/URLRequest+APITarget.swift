//
//  URLRequest+APITarget.swift
//
//
//  Created by József Vesza on 2023. 05. 10..
//

import Foundation
import RemoteService

extension URLRequest {
    public enum RequestBuilderError: Error {
        case incorrectURL
        case dataEncoding(Encodable)
    }
    
    public init<T: APITarget>(target: T) throws {
        var components = URLComponents()
        components.scheme = "https"
        components.host = target.baseURL.absoluteString
        components.path = target.path
        
        if case .withParameters(parameters: let parameters) = target.requestType {
            components.queryItems = []
            parameters.forEach { parameter in
                guard let parameterValue = parameter.value as? String else { return }
                components.queryItems?.append(URLQueryItem(name: parameter.key, value: parameterValue))
            }
        }
        
        guard let url = components.url else {
            throw RequestBuilderError.incorrectURL
        }
        
        self.init(url: url)
        
        switch target.method {
        case .get:
            httpMethod = "GET"
        case .post(let data):
            guard let data = data else {
                httpMethod = "POST"
                break
            }
            
            guard let body = try? JSONEncoder().encode(AnyEncodable(data)) else {
                throw RequestBuilderError.dataEncoding(data)
            }
            httpMethod = "POST"
            httpBody = body
        case .put(let data):
            guard let body = try? JSONEncoder().encode(AnyEncodable(data)) else {
                throw RequestBuilderError.dataEncoding(data)
            }
            httpMethod = "PUT"
            httpBody = body
        case .delete:
            httpMethod = "DELETE"
        }
        
        target.headers?.forEach { key, value in
            setValue(value, forHTTPHeaderField: key)
        }
    }
}
