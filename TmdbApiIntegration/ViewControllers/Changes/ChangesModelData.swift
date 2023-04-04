//
//  ChangesModelData.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 02/04/23.
//

import Foundation

// MARK: - Changes
struct Changes: Codable {
    let changes: [Change]
}

// MARK: - Change
struct Change: Codable {
    let key: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id, action, time, iso639_1: String
    let iso3166_1, value, originalValue: String

    enum CodingKeys: String, CodingKey {
        case id, action, time
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case value
        case originalValue = "original_value"
    }
}
