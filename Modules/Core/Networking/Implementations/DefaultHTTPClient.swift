//
//  DefaultHTTPClient.swift
//  Networking
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/01/26.
//

import Foundation

public final class DefaultHTTPClient: HTTPClient {
    private let baseURL: String?
    private let session: SessionHTTP
    private let decoder: ResponseDecoder

    public init(
        baseURL: String? = nil,
        session: SessionHTTP,
        decoder: ResponseDecoder = JSONResponseDecoder()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }

    public func send<T: Decodable>(
        _ request: HTTPRequest
    ) async throws -> T {

        let urlRequest: URLRequest
        do {
            urlRequest = try request.build(baseURL: baseURL)
        } catch {
            throw NetworkError.invalidRequest
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.request(for: urlRequest)
        } catch {
            throw NetworkError.transportError(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTPResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.httpError(
                statusCode: httpResponse.statusCode,
                data: data
            )
        }

        guard !data.isEmpty else {
            throw NetworkError.emptyResponse
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
