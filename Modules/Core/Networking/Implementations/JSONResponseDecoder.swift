//
//  JSONResponseDecoder.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public final class JSONResponseDecoder: ResponseDecoder {

    private let decoder: JSONDecoder

    public init(decoder: JSONDecoder = .api) {
        self.decoder = decoder
    }

    public func decode<T>(
        _ type: T.Type,
        from data: Data
    ) throws -> T where T: Decodable {
        try decoder.decode(T.self, from: data)
    }
}
