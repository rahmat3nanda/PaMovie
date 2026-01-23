//
//  PopularMoviesResponse.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation

public struct PopularMoviesResponse: Decodable {
    public let results: [MovieDTO]
}
