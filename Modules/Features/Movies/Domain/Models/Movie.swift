//
//  Movie.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation

public struct Movie: Identifiable, Equatable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let isFavorite: Bool

    public var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
