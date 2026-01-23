//
//  DefaultMovieAPI.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Networking

final class DefaultMovieAPI: MovieAPI {
    private let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func fetchPopular() async throws -> PopularMoviesResponse {
        try await client.send(
            HTTPRequest(path: "/movie/popular", method: .get)
        )
    }
}
