//
//  MoviesApiProvider.swift
//  Movie-App
//
//  Created by Mohamed Ali on 29/03/2024.
//

import Foundation
import Moya

protocol PopularMovieProviderProtocol {
    func getPopularMovies(page: Int, completion: @escaping (Result<PopularMovieResponse, Error>) -> ())
}

class MoviesApiProvider: PopularMovieProviderProtocol {
    
    private let provider: MoyaProvider<MoviesApi>
    
    init() {
        let networkLogger: NetworkLoggerPlugin = {
            let networkLogger = NetworkLoggerPlugin()
            networkLogger.configuration.logOptions = .verbose
            return networkLogger
        }()
        provider = MoyaProvider<MoviesApi>(plugins: [networkLogger])
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
