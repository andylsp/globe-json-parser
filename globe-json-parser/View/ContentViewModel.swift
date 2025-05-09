//
//  ContentViewModel.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/9/25.
//

import SwiftUI
import SwiftData

extension ContentView {
    @Observable
    class ContentViewModel {
        var modelContext: ModelContext
        var items = [Item]()

        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }

        // MARK: - Public Methods
        func addItem() {
            withAnimation {
                let newItem = Item(timestamp: Date())
                modelContext.insert(newItem)
                fetchData()
            }
        }

        func deleteItems(offsets: IndexSet) {
            withAnimation {
                for index in offsets {
                    modelContext.delete(items[index])
                }
                fetchData()
            }
        }

        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Item>(sortBy: [SortDescriptor(\.timestamp)])
                items = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }

        func fetchDataFromAPI() async {

        }
    }
}
