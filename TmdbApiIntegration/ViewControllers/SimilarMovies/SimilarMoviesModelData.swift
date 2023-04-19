//
//  SimilarMoviesModelData.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 18/04/23.
//

import Foundation

// MARK: - SimilarMovies
struct SimilarMovies: Codable {
    let page: Int
    let results: [SimilarMoviesResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarMoviesResult: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguagee
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguagee: String, Codable {
    case de = "de"
    case en = "en"
    case nl = "nl"
    case ru = "ru"
}
