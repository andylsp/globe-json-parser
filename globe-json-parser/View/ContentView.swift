//
//  ContentView.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/9/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var viewModel: ContentViewModel

    init(modelContext: ModelContext) {
        let viewModel = ContentViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }

    // MARK: - View Body
    var body: some View {
        content
            .onAppear {
                guard !viewModel.isDownloading else { return }
                viewModel.fetchData()
            }
    }
}

// MARK: - View Content
extension ContentView {
    @ViewBuilder
    private var content: some View {
        if viewModel.items.isEmpty || viewModel.isDownloading {
            if viewModel.isDownloading {
                ProgressView()
                    .progressViewStyle(.automatic)
            } else {
                downloadButton
            }
        } else {
            listView
        }
    }

    @ViewBuilder
    private var downloadButton: some View {
        Button(action: viewModel.downloadItems) {
            Label("Download Items", systemImage: "arrow.down.circle")
        }
    }

    @ViewBuilder
    private var listView: some View {
        NavigationStack(path: $navigationModel.path) {
            List {
                ForEach(viewModel.items) { item in
                    listRowView(item: item)
                        .onTapGesture {
                            navigationModel.navigateTo(item)
                        }
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .navigationDestination(for: Item.self) { item in
                ContentDetailView(item: item)
            }
            .navigationTitle(Text("Items"))
        }
        .navigationBarTitleDisplayMode(.inline)

    }

    @ViewBuilder
    private func listRowView(item: Item) -> some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.headline)
                .lineLimit(1)
        }
    }
}

#Preview {
    ContentView(modelContext: ModelContext(try! ModelContainer(for: Item.self)))
        .modelContainer(for: Item.self, inMemory: true)
}
