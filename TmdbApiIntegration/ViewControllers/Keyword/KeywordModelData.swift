//
//  KeywordModelData.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 06/04/23.
//

import Foundation

// MARK: - Keywords
struct Keywords: Codable {
    let id: Int
    let keywords: [Keyword]
}

// MARK: - Keyword
struct Keyword: Codable {
    let id: Int
    let name: String
}
