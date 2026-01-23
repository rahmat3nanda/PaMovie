//
//  MovieAPI.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation

public protocol MovieAPI {
    func fetchPopular() async throws -> PopularMoviesResponse
}
