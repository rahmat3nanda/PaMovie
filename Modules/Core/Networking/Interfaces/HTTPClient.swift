//
//  HTTPClient.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public protocol HTTPClient {
    func send<T: Decodable>(_ request: HTTPRequest, responseType: T.Type) async throws -> T
}
