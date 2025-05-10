//
//  APIManager.swift
//  globe-json-parser
//
//  Created by Jonathan Andy Lim on 5/10/25.
//

import Foundation
import Alamofire

final class APIManager {
    static let shared = APIManager()
    
    private init() {}

    func get<T: Codable>(
        url: String,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = URLEncoding.default
    ) async -> DataResponse<T, AFError> {
        print("GET \(url)")
        return await AF.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: encoding,
            interceptor: .retryPolicy,
        )
        .validate()
        .serializingDecodable(T.self)
        .response
    }
}
