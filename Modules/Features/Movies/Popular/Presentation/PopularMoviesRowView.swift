//
//  PopularMoviesRowView.swift
//  Movies
//
//  Created by Rahmat Trinanda Pramudya Amar on 23/01/26.
//

import Foundation
import SwiftUI
import UI

struct PopularMoviesRowView: View {

    let movie: Movie

    var body: some View {
        HStack(spacing: 12) {

            RemoteImageView(
                url: movie.posterURL,
                width: 60,
                height: 90,
                cornerRadius: 8
            )

            VStack(alignment: .leading, spacing: 6) {

                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }

            Spacer(minLength: 0)
        }
        .padding(.vertical, 8)
    }
}
