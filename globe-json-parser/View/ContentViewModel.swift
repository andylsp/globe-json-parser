//
//  ContentViewModel.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/9/25.
//

import SwiftUI
import SwiftData
import Alamofire

extension ContentView {
    @Observable
    class ContentViewModel {
        var modelContext: ModelContext
        var isDownloading = false
        var posts = [PostItem]()

        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }

        // MARK: - Public Methods
        func deleteItems(offsets: IndexSet) {
            withAnimation {
                for index in offsets {
                    modelContext.delete(posts[index])
                }
                do {
                    try modelContext.save()
                } catch {
                    print(error.localizedDescription)
                }
                fetchPosts()
            }
        }

        func fetchPosts() {
            do {
                let descriptor = FetchDescriptor<PostItem>(sortBy: [SortDescriptor(\.title)])
                posts = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
    }
}

extension ContentView.ContentViewModel {
    func downloadPosts() {
        isDownloading = true
        Task { @MainActor in
            let items = await GetPostsFromAPIUseCase().invoke()
            insertItems(items)
            isDownloading = false
        }
    }

    private func insertItems(_ items: [PostItem]) {
        let container = modelContext.container

        Task.detached {
            let handler = DataHandler(modelContainer: container)
            await withTaskGroup { group in
                for item in items {
                    group.addTask {
                        await handler.insertItem(item)
                    }
                }
            }
            Task { @MainActor in
                self.fetchPosts()
            }
        }
    }
}

