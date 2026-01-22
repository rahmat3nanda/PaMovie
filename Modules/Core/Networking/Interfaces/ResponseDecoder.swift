//
//  ResponseDecoder.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}
