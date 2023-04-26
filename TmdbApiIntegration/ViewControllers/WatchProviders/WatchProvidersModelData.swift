//
//  WatchProvidersModelData.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 26/04/23.
//

import Foundation

// MARK: - WatchProviders
struct WatchProviders: Codable {
    let id: Int
    let results: [String: watchProviderResult]
}

// MARK: - Result
struct watchProviderResult: Codable {
    let link: String
    let flatrate: [Flatrate]
}

// MARK: - Flatrate
struct Flatrate: Codable {
    let logoPath: LogoPath
    let providerID: Int
    let providerName: ProviderName
    let displayPriority: Int

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
        case displayPriority = "display_priority"
    }
}

enum LogoPath: String, Codable {
    case mShqQVDhHoK7VUbfYG3Un6XE8MvJpg = "/mShqQVDhHoK7VUbfYG3Un6xE8Mv.jpg"
    case t2YyOv40HZeVlLjYsCSPHnWLk4WJpg = "/t2yyOv40HZeVlLjYsCsPHnWLk4W.jpg"
}

enum ProviderName: String, Codable {
    case netflix = "Netflix"
    case netflixBasicWithAds = "Netflix basic with Ads"
}
