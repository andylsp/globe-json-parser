//
//  NavigationModel.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/11/25.
//

import SwiftUI

class NavigationModel: ObservableObject {
    @Published var path = NavigationPath()

    @MainActor
    func navigateTo(_ destination: any Hashable,
                    fromSearch: Bool = false) {
        path.append(destination)
    }

    @MainActor
    func popLast() {
        path.removeLast()
    }

    @MainActor
    func popToRoot() {
        path = .init()
    }
}
