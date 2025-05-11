//
//  DataHandler.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/10/25.
//

import Foundation
import SwiftData

@ModelActor
actor DataHandler {
    func insertItem(_ item: Item) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
