//
//  GetPostsFromAPIUseCase.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/10/25.
//

import Foundation
import Alamofire

protocol GetPostsFromAPIUseCaseProtocol {
    func invoke() async -> [PostItem]
}

struct GetPostsFromAPIUseCase: GetPostsFromAPIUseCaseProtocol {
    private let apiManager = APIManager.shared

    func invoke() async -> [PostItem] {
        let response: DataResponse<[PostItem], AFError> = await apiManager.get(url: "https://jsonplaceholder.typicode.com/posts")
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            fatalError("Error: \(error)")
        }
    }
}
