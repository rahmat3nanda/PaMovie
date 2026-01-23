//
//  MovieDTO.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation

public struct MovieDTO: Decodable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}
