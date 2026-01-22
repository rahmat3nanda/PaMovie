//
//  NetworkError.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public enum NetworkError: Error, Equatable {
    /// Failed to build URLRequest
    case invalidRequest
    /// Response is not HTTPURLResponse
    case nonHTTPResponse
    /// HTTP status code is not in 200...299
    case httpError(statusCode: Int, data: Data?)
    /// Empty response data
    case emptyResponse
    /// Failed to decode response
    case decodingFailed(Error)
    /// Underlying session error (URLSession / Alamofire / etc)
    case transportError(Error)

    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequest, .invalidRequest),
            (.nonHTTPResponse, .nonHTTPResponse),
            (.emptyResponse, .emptyResponse):
            return true
        case let (.httpError(code1, _), .httpError(code2, _)):
            return code1 == code2
        case (.decodingFailed, .decodingFailed):
            return true
        case (.transportError, .transportError):
            return true
        default:
            return false
        }
    }
}
