//
//  SessionHTTP.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public protocol SessionHTTP {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
