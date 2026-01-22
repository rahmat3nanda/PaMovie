//
//  MockResponseDecoder.swift
//  NetworkingTests
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation
@testable import Networking

final class MockResponseDecoder: ResponseDecoder {

    var decodedObject: Any?
    var error: Error?

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {

        if let error = error {
            throw error
        }

        guard let object = decodedObject as? T else {
            throw NSError(domain: "MockDecoder", code: -999)
        }

        return object
    }
}
