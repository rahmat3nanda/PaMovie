//
//  JSONDecoder+API.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public extension JSONDecoder {
    static let api: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
