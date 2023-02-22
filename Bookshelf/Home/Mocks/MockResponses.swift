//
//  MockResponses.swift
//  Bookshelf
//
//  Created by József Vesza on 2023. 02. 22..
//

import Foundation

enum MockResponses {
    static let topFreeBooks = """
    {
      "feed": {
        "title": "Top Free",
        "id": "https://rss.applemarketingtools.com/api/v2/us/books/top-free/10/books.json",
        "author": {
          "name": "Apple",
          "url": "https://www.apple.com/"
        },
        "links": [
          {
            "self": "https://rss.applemarketingtools.com/api/v2/us/books/top-free/10/books.json"
          }
        ],
        "copyright": "Copyright © 2023 Apple Inc. All rights reserved.",
        "country": "us",
        "icon": "https://www.apple.com/favicon.ico",
        "updated": "Wed, 22 Feb 2023 12:39:37 +0000",
        "results": [
          {
            "artistName": "Kate Bold",
            "id": "6443885767",
            "name": "Last Breath (A Kaylie Brooks Psychological Suspense Thriller—Book 1)",
            "releaseDate": "2022-11-18",
            "kind": "books",
            "artistId": "1566629948",
            "artistUrl": "https://books.apple.com/us/author/kate-bold/id1566629948",
            "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Publication122/v4/af/c9/d2/afc9d293-69a9-0df2-ca3b-84ab83df71fc/9781094395746.jpg/100x150bb.png",
            "genres": [
              {
                "genreId": "9032",
                "name": "Mysteries & Thrillers",
                "url": "https://itunes.apple.com/us/genre/id9032"
              },
              {
                "genreId": "38",
                "name": "Books",
                "url": "https://itunes.apple.com/us/genre/id38"
              },
              {
                "genreId": "10055",
                "name": "Women Sleuths",
                "url": "https://itunes.apple.com/us/genre/id10055"
              }
            ],
            "url": "https://books.apple.com/us/book/last-breath-a-kaylie-brooks-psychological-suspense/id6443885767"
          }
        ]
      }
    }
    """.data(using: .utf8)!

    static let topPaidBooks = """
    {
      "feed": {
        "title": "Top Paid",
        "id": "https://rss.applemarketingtools.com/api/v2/us/books/top-paid/10/books.json",
        "author": {
          "name": "Apple",
          "url": "https://www.apple.com/"
        },
        "links": [
          {
            "self": "https://rss.applemarketingtools.com/api/v2/us/books/top-paid/10/books.json"
          }
        ],
        "copyright": "Copyright © 2023 Apple Inc. All rights reserved.",
        "country": "us",
        "icon": "https://www.apple.com/favicon.ico",
        "updated": "Wed, 22 Feb 2023 12:45:45 +0000",
        "results": [
          {
            "artistName": "Mark Greaney",
            "id": "6442846763",
            "name": "Burner",
            "releaseDate": "2023-02-21",
            "kind": "books",
            "artistId": "357923457",
            "artistUrl": "https://books.apple.com/us/author/mark-greaney/id357923457",
            "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Publication122/v4/6b/6a/ae/6b6aae6a-ece2-9d3b-486b-553a098f6b80/9780593548110.d.jpg/100x151bb.png",
            "genres": [
              {
                "genreId": "9032",
                "name": "Mysteries & Thrillers",
                "url": "https://itunes.apple.com/us/genre/id9032"
              },
              {
                "genreId": "38",
                "name": "Books",
                "url": "https://itunes.apple.com/us/genre/id38"
              },
              {
                "genreId": "9031",
                "name": "Fiction & Literature",
                "url": "https://itunes.apple.com/us/genre/id9031"
              },
              {
                "genreId": "10039",
                "name": "Action & Adventure",
                "url": "https://itunes.apple.com/us/genre/id10039"
              }
            ],
            "url": "https://books.apple.com/us/book/burner/id6442846763"
          }
        ]
      }
    }
    """.data(using: .utf8)!

    static let topAudio = """
    {
      "feed": {
        "title": "Top Audiobooks",
        "id": "https://rss.applemarketingtools.com/api/v2/us/audio-books/top/10/audio-books.json",
        "author": {
          "name": "Apple",
          "url": "https://www.apple.com/"
        },
        "links": [
          {
            "self": "https://rss.applemarketingtools.com/api/v2/us/audio-books/top/10/audio-books.json"
          }
        ],
        "copyright": "Copyright © 2023 Apple Inc. All rights reserved.",
        "country": "us",
        "icon": "https://www.apple.com/favicon.ico",
        "updated": "Wed, 22 Feb 2023 12:44:27 +0000",
        "results": [
          {
            "artistName": "Carley Fortune",
            "id": "1580664675",
            "name": "Every Summer After (Unabridged)",
            "releaseDate": "2022-05-10",
            "kind": "audio-books",
            "artistId": "1580661567",
            "artistUrl": "https://books.apple.com/us/author/carley-fortune/id1580661567",
            "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music112/v4/49/84/cf/4984cfdd-7984-dedf-74e7-f4425c778c7d/9780593551899.d.jpg/100x100bb.png",
            "genres": [
              {
                "genreId": "50000040",
                "name": "Fiction",
                "url": "https://itunes.apple.com/us/genre/id50000040"
              },
              {
                "genreId": "50000024",
                "name": "Audiobooks",
                "url": "https://itunes.apple.com/us/genre/id50000024"
              },
              {
                "genreId": "50000069",
                "name": "Romance",
                "url": "https://itunes.apple.com/us/genre/id50000069"
              }
            ],
            "url": "https://books.apple.com/us/audiobook/every-summer-after-unabridged/id1580664675"
          }
        ]
      }
    }
    """.data(using: .utf8)!
}
