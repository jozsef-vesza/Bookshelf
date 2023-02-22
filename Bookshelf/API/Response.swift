//
//  Response.swift
//  Bookshelf
//
//  Created by József Vesza on 2023. 02. 22..
//

import Foundation

struct Response: Codable {
    let feed: Feed?
}

struct Feed: Codable {
    let title: String?
    let results: [Book]?
}

public struct Book: Codable, Hashable {
    public let authorName: String?
    public let title: String?
    public let artworkURLString: String?

    public var artworkURL: URL? {
        guard let artworkURLString else { return nil }
        return URL(string: artworkURLString)
    }

    enum CodingKeys: String, CodingKey {
        case authorName = "artistName"
        case title = "name"
        case artworkURLString = "artworkUrl100"
    }
}
