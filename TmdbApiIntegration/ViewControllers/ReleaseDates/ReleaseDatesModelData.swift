//
//  ReleaseDatesModelData.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 17/04/23.
//

import Foundation

struct ReleaseDates : Codable {
    let id : Int?
    let results : [ReleaseDatesResults]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        results = try values.decodeIfPresent([ReleaseDatesResults].self, forKey: .results)
    }

}

struct Release_dates : Codable {
    let certification : String?
    let descriptors : [String]?
    let iso_639_1 : String?
    let note : String?
    let release_date : String?
    let type : Int?

    enum CodingKeys: String, CodingKey {

        case certification = "certification"
        case descriptors = "descriptors"
        case iso_639_1 = "iso_639_1"
        case note = "note"
        case release_date = "release_date"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        certification = try values.decodeIfPresent(String.self, forKey: .certification)
        descriptors = try values.decodeIfPresent([String].self, forKey: .descriptors)
        iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
        note = try values.decodeIfPresent(String.self, forKey: .note)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
    }

}

struct ReleaseDatesResults : Codable {
    let iso_3166_1 : String?
    let release_dates : [Release_dates]?

    enum CodingKeys: String, CodingKey {

        case iso_3166_1 = "iso_3166_1"
        case release_dates = "release_dates"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso_3166_1 = try values.decodeIfPresent(String.self, forKey: .iso_3166_1)
        release_dates = try values.decodeIfPresent([Release_dates].self, forKey: .release_dates)
    }

}

