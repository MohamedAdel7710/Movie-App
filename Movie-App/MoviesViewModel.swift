//
//  MoviesViewModel.swift
//  Movie-App
//
//  Created by Mohamed Ali on 29/03/2024.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var moviesList: [Movie] = []
    let movieProvider : PopularMovieProviderProtocol
    var page: Int = 1
    
    init(movieProvider: PopularMovieProviderProtocol = MoviesApiProvider()){
        self.movieProvider = movieProvider
    }
    
    func fetchMovies(page: Int = 1) {
        movieProvider.getPopularMovies(page: page) { [weak self] result in
            switch result {
            case .success(let response):
                self?.moviesList = response.movies
            case .failure(let error):
                print(error)
            }
        }
    }
}
