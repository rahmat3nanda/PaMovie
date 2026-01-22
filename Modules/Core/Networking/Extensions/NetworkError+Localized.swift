//
//  NetworkError+Localized.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid request."
        case .nonHTTPResponse:
            return "Invalid server response."
        case .httpError(let code, _):
            return "Server error (\(code))."
        case .emptyResponse:
            return "Empty response from server."
        case .decodingFailed:
            return "Failed to read server data."
        case .transportError:
            return "Network connection error."
        }
    }
}
