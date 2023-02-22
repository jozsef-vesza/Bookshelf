//
//  BookshelfAPI.swift
//  Bookshelf
//
//  Created by József Vesza on 2023. 02. 22..
//

import Foundation
import RemoteService

public enum BookshelfAPI {
    case topFreeBooks, topPaidBooks, topAudiobooks
}

extension BookshelfAPI: APITarget {
    public var baseURL: URL {
        URL(string: "rss.applemarketingtools.com")!
    }

    public var path: String {
        switch self {
        case .topFreeBooks:
            return "/api/v2/us/books/top-free/10/books.json"
        case .topPaidBooks:
            return "/api/v2/us/books/top-paid/10/books.json"
        case .topAudiobooks:
            return "/api/v2/us/audio-books/top/10/audio-books.json"
        }
    }

    public var method: APIMethod {
        .get
    }

    public var headers: [String: String]? {
        [:]
    }

    public var requestType: RequestType {
        .plain
    }
}
