//
//  ContentView.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/9/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
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
                viewModel.fetchPosts()
            }
    }
}

// MARK: - View Content
extension ContentView {
    @ViewBuilder
    private var content: some View {
        if viewModel.posts.isEmpty || viewModel.isDownloading {
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
        Button(action: viewModel.downloadPosts) {
            Label("Download Posts", systemImage: "arrow.down.circle")
        }
    }

    @ViewBuilder
    private var listView: some View {
        NavigationStack {
            List {
                ForEach(viewModel.posts) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                            .lineLimit(1)
                    }
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    ContentView(modelContext: ModelContext(try! ModelContainer(for: Item.self)))
        .modelContainer(for: Item.self, inMemory: true)
}
