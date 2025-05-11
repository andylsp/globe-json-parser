//
//  Item.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/10/25.
//

import Foundation
import SwiftData

@Model
final class Item: Codable, Identifiable, Sendable {
    var id: Int
    var userId: Int
    var title: String
    var body: String

    enum CodingKeys: CodingKey {
        case id
        case userId
        case title
        case body
    }

    init(id: Int = 0, userId: Int = 0, title: String = "", body: String = "") {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        userId = try container.decode(Int.self, forKey: .userId)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
    }
}
