//
//  Item.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/9/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
