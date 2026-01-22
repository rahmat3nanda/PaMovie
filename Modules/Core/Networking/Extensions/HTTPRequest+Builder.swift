//
//  HTTPRequest+Builder.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public extension HTTPRequest {
    func build() throws -> URLRequest {
        var components = URLComponents(string: baseURL + path)

        if !query.isEmpty {
            components?.queryItems = query.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body

        headers.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return urlRequest
    }
}
