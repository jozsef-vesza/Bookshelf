//
//  HomeViewModel.swift
//  Bookshelf
//
//  Created by József Vesza on 2023. 02. 22..
//

import Combine
import Foundation
import RemoteService

struct HomeViewData {
    struct Section: Hashable {
        let title: String
        let books: [Book]
    }

    let sections: [Section]
}

struct HomeItemViewData {
    let title: String?
    let author: String?
    let thumbnailURL: URL?
}

class HomeViewModel: ObservableObject {
    @Published var viewData: HomeViewData = .init(sections: [])

    let service: RemoteService<BookshelfAPI>

    private var cancellables = Set<AnyCancellable>()

    init(service: RemoteService<BookshelfAPI>) {
        self.service = service
        
        $viewData
            .handleEvents(receiveSubscription: { _ in
                self.loadBooks()
            })
            .sink(receiveValue: { _ in })
            .store(in: &cancellables)
    }

    private func loadBooks() {
        let topFreeBooksPublisher = service.request(.topFreeBooks)
        let topPaidPublisher = service.request(.topPaidBooks)
        let topAudiobooksPublisher = service.request(.topAudiobooks)

        Publishers
            .CombineLatest3(topFreeBooksPublisher, topPaidPublisher, topAudiobooksPublisher)
            .receive(on: DispatchQueue.main)
            .map { [unowned self] topFree, topPaid, topAudio in
                return (parseBooks(response: topFree),
                        parseBooks(response: topPaid),
                        parseBooks(response: topAudio))
            }
            .sink(receiveCompletion: { _ in }) { [unowned self] topFree, topPaid, topAudio in
                viewData = HomeViewData(sections: [
                    HomeViewData.Section(title: "Top Free Books", books: topFree),
                    HomeViewData.Section(title: "Top Paid Books", books: topPaid),
                    HomeViewData.Section(title: "Top Audiobooks", books: topAudio)
                ])
            }
            .store(in: &cancellables)
    }

    private func parseBooks(response: Data) -> [Book] {
        do {
            return try JSONDecoder().decode(Response.self, from: response).feed?.results ?? []
        } catch {
            return []
        }
    }
}
