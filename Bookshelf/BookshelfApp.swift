//
//  BookshelfApp.swift
//  Bookshelf
//
//  Created by József Vesza on 2023. 05. 10..
//

import SwiftUI
import RemoteServiceLive

@main
struct BookshelfApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(service: .live()))
        }
    }
}
