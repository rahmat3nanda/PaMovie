//
//  MovieMapper.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Database

enum MovieMapper {
    static func toDomain(
        dto: MovieDTO,
        isFavorite: Bool = false
    ) -> Movie {
        Movie(
            id: dto.id,
            title: dto.title,
            overview: dto.overview,
            posterPath: dto.posterPath,
            isFavorite: isFavorite
        )
    }

    static func fromRecord(_ record: MovieRecord) -> Movie {
        Movie(
            id: record.id,
            title: record.title,
            overview: record.overview,
            posterPath: record.posterPath,
            isFavorite: record.isFavorite
        )
    }

    static func toRecord(_ movie: Movie) -> MovieRecord {
        MovieRecord(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            posterPath: movie.posterPath,
            isFavorite: movie.isFavorite
        )
    }
}
