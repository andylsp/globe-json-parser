//
//  globe_json_parserApp.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/9/25.
//

import SwiftUI
import SwiftData

@main
struct globe_json_parserApp: App {
    var modelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: modelContainer.mainContext)
        }
        .modelContainer(modelContainer)
    }
}
