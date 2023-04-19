//
//  ListsModelData.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 11/04/23.
//

import Foundation

struct Lists : Codable {
    let id : Int?
    let page : Int?
    let results : [Results]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }

}

struct Results : Codable {
    let description : String?
    let favorite_count : Int?
    let id : Int?
    let item_count : Int?
    let iso_639_1 : String?
    let list_type : String?
    let name : String?
    let poster_path : String?

    enum CodingKeys: String, CodingKey {

        case description = "description"
        case favorite_count = "favorite_count"
        case id = "id"
        case item_count = "item_count"
        case iso_639_1 = "iso_639_1"
        case list_type = "list_type"
        case name = "name"
        case poster_path = "poster_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        favorite_count = try values.decodeIfPresent(Int.self, forKey: .favorite_count)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        item_count = try values.decodeIfPresent(Int.self, forKey: .item_count)
        iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
        list_type = try values.decodeIfPresent(String.self, forKey: .list_type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
    }

}



