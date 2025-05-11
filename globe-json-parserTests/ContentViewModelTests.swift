//
//  ContentViewModelTests.swift
//  globe-json-parserTests
//
//  Created by Jonathan Andy Lim on 5/11/25.
//

import XCTest
import SwiftData
import Combine
@testable import globe_json_parser

final class ContentViewModelTests: XCTestCase {
    private var modelContainer: ModelContainer = {
        let schema = Schema([
            Item.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testDownloadAndSaveToPersistentStore() async {
        let viewModel = ContentView.ContentViewModel(modelContext: modelContainer.mainContext)
        viewModel.downloadItems()
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        XCTAssertNotEqual(viewModel.items.count, 0, "The items are empty")
    }
}
