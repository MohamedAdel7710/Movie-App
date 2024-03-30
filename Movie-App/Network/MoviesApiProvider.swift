//
//  MoviesApiProvider.swift
//  Movie-App
//
//  Created by Mohamed Ali on 29/03/2024.
//

import Foundation
import Moya

class MoviesApiProvider {
    
    private let provider: MoyaProvider<MoviesApi>
    
    init() {
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        provider = MoyaProvider<MoviesApi>(plugins: [logger])
    }
    
    func getPopularMovies(page: Int, completion: @escaping (Result<PopularMovieResponse, Error>) -> ()) {
        provider.request(.PopularMovie(page: page)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PopularMovieResponse.self, from: response.data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
