//
//  TranslationModelData.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 26/04/23.
//

import Foundation

// MARK: - Translations
struct Translations: Codable {
    let id: Int
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let iso3166_1, iso639_1, name, englishName: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case iso639_1 = "iso_639_1"
        case name
        case englishName = "english_name"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let homepage: String
    let overview: String
    let runtime: Int
    let tagline, title: String
}
