//
//  MockSessionHTTP.swift
//  NetworkingTests
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation
@testable import Networking

final class MockSessionHTTP: SessionHTTP {

    enum Result {
        case success(Data, URLResponse)
        case failure(Error)
    }

    var result: Result!

    func request(for request: URLRequest) async throws -> (Data, URLResponse) {
        switch result {
        case let .success(data, response):
            return (data, response)
        case let .failure(error):
            throw error
        case .none:
            fatalError("MockSessionHTTP result not set")
        }
    }
}
