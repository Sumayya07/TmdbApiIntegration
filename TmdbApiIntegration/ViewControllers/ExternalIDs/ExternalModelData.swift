//
//  ExternalsModelData.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 05/04/23.
//

import Foundation

// MARK: - External
struct External: Codable {
    let id: Int
    let imdbID: String
    let wikidataID, facebookID, instagramID, twitterID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case imdbID = "imdb_id"
        case wikidataID = "wikidata_id"
        case facebookID = "facebook_id"
        case instagramID = "instagram_id"
        case twitterID = "twitter_id"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
