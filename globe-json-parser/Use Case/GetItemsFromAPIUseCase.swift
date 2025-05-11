//
//  GetItemsFromAPIUseCase.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/10/25.
//

import Foundation
import Alamofire

protocol GetItemsFromAPIUseCaseProtocol {
    func invoke() async -> [Item]
}

struct GetItemsFromAPIUseCase: GetItemsFromAPIUseCaseProtocol {
    private let apiManager = APIManager.shared

    func invoke() async -> [Item] {
        let response: DataResponse<[Item], AFError> = await apiManager.get(url: "https://jsonplaceholder.typicode.com/posts")
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            fatalError("Error: \(error)")
        }
    }
}
