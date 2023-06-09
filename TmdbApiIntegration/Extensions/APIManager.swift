//
//  APIManager.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 28/03/23.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    let movieListApi = "https://api.themoviedb.org/3/genre/movie/list?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US"
    
    let detailsApi = "https://api.themoviedb.org/3/movie/725201?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US"
    
    let titlesApi = "https://api.themoviedb.org/3/movie/725201/alternative_titles?api_key=e8db82ed17e9ab064d2bd8cad9b06a94"
    
    let changesApi = "https://api.themoviedb.org/3/movie/725201/changes?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&page=1&start_date=11-01-2023&end_date=21-01-2023"
    
    let creditsApi = "https://api.themoviedb.org/3/movie/725201/credits?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US"
    
    let externalApi = "https://api.themoviedb.org/3/movie/725201/external_ids?api_key=e8db82ed17e9ab064d2bd8cad9b06a94"
    
    let keywordApi = "https://api.themoviedb.org/3/movie/725201/keywords?api_key=e8db82ed17e9ab064d2bd8cad9b06a94"
    
    let listsApi = "https://api.themoviedb.org/3/movie/725201/lists?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US&page=1"
    
    let recommendationsApi = "https://api.themoviedb.org/3/movie/725201/recommendations?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US&page=1"
    
    let releaseDatesApi = "https://api.themoviedb.org/3/movie/725201/release_dates?api_key=e8db82ed17e9ab064d2bd8cad9b06a94"
    
    let reviewsApi = "https://api.themoviedb.org/3/movie/725201/reviews?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US&page=1"
    
    let similarMoviesApi = "https://api.themoviedb.org/3/movie/725201/similar?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US&page=1"
    
    let translationsApi = "https://api.themoviedb.org/3/movie/725201/translations?api_key=e8db82ed17e9ab064d2bd8cad9b06a94"
    
    let videosApi = "https://api.themoviedb.org/3/movie/725201/videos?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US"
    
    let watchProvidersApi = "https://api.themoviedb.org/3/movie/725201/watch/providers?api_key=e8db82ed17e9ab064d2bd8cad9b06a94"
    
    let popularApi = "https://api.themoviedb.org/3/movie/popular?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US&page=1"
    
    let nowPlayingApi = "https://api.themoviedb.org/3/movie/now_playing?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US&page=1"
    
    let topRatedApi = "https://api.themoviedb.org/3/movie/top_rated?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US&page=1"
    
    let upcomingMoviesApi = "https://api.themoviedb.org/3/movie/now_playing?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US&page=1"
    
    
    func load<T: Decodable>(urlRequest: URLRequest, type:T.Type, completion: @escaping (Swift.Result<T,Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("json >>>>", json)
                
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch (let error) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
}
