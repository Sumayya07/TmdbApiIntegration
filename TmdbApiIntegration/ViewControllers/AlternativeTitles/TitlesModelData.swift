//
//  TitlesModelData.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 30/03/23.
//

import Foundation

// MARK: - Titles
struct Titles: Codable {
    let id: Int
    let titles: [Title]
}

// MARK: - Title
struct Title: Codable {
    let iso3166_1, title, type: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case title, type
    }
}
