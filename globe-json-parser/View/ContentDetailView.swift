//
//  ContentDetailView.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/11/25.
//

import SwiftUI

struct ContentDetailView: View {
    @State var item: Item

    var body: some View {
        List {
            LabeledContent("ID", value: "\(item.id)")
            LabeledContent("User ID", value: "\(item.userId)")
            LabeledContent("Title", value: item.title)
            LabeledContent("Body", value: item.body)
        }
        .navigationTitle("Details")
    }
}

#Preview {
    ContentDetailView(item: .init())
}
