//
//  HTTPRequest.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public struct HTTPRequest {
    public let baseURL: String
    public let path: String
    public let method: HTTPMethod
    public let headers: [String: String]
    public let query: [String: String]
    public let body: Data?

    public init(
        baseURL: String = "",
        path: String,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        query: [String: String] = [:],
        body: Data? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.query = query
        self.body = body
    }
}
