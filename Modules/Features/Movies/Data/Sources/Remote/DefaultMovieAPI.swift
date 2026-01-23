//
//  DefaultMovieAPI.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Networking

public final class DefaultMovieAPI: MovieAPI {
    private let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }

    public func fetchPopular() async throws -> PopularMoviesResponse {
        try await client.send(
            HTTPRequest(path: "/movie/popular", method: .get)
        )
    }
}
