//
//  PopularMovieResponse.swift
//  Movie-App
//
//  Created by Mohamed Ali on 29/03/2024.
//

import Foundation

struct PopularMovieResponse: Codable {
    let page: Int
    let movies: [Movie] // Create movie model
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Codable {
    let id: Int
    let overview: String
    let posterPath, releaseDate, title: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title
        case rating = "vote_average"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
