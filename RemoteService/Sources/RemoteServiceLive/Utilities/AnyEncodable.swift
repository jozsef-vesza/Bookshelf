//
//  AnyEncodable.swift
//  
//
//  Created by József Vesza on 2023. 05. 10..
//

public struct AnyEncodable: Encodable {
    public let encodable: Encodable
    
    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }
    
    public func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}

