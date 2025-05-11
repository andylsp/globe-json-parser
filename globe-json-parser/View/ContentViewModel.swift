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
        var items = [Item]()

        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }

        // MARK: - Public Methods
        func deleteItems(offsets: IndexSet) {
            withAnimation {
                for index in offsets {
                    modelContext.delete(items[index])
                }
                do {
                    try modelContext.save()
                } catch {
                    print(error.localizedDescription)
                }
                fetchData()
            }
        }

        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Item>(sortBy: [SortDescriptor(\.title)])
                items = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
    }
}

extension ContentView.ContentViewModel {
    func downloadItems() {
        Task { @MainActor in
            isDownloading = true
            let items = await GetItemsFromAPIUseCase().invoke()
            insertItems(items)
            isDownloading = false
        }
    }

    private func insertItems(_ items: [Item]) {
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
                self.fetchData()
            }
        }
    }
}

