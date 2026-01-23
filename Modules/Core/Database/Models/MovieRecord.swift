//
//  MovieRecord.swift
//  Database
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation

public struct MovieRecord: Equatable, Identifiable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let isFavorite: Bool

    public init(
        id: Int,
        title: String,
        overview: String,
        posterPath: String?,
        isFavorite: Bool
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.isFavorite = isFavorite
    }
}
