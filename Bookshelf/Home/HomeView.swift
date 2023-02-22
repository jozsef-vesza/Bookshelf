//
//  ContentView.swift
//  Bookshelf
//
//  Created by József Vesza on 2023. 05. 10..
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        List(viewModel.viewData.sections, id: \.self) { section in
            Section(header: Text(section.title)) {
                ForEach(section.books, id: \.self) {
                    Text($0.title ?? "")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(service: .mockedDataResponse(data: [
            BookshelfAPI.topPaidBooks.path: MockResponses.topFreeBooks,
            BookshelfAPI.topFreeBooks.path: MockResponses.topPaidBooks,
            BookshelfAPI.topAudiobooks.path: MockResponses.topAudio,
        ])))
    }
}
