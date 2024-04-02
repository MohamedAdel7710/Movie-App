//
//  MoviesApi.swift
//  Movie-App
//
//  Created by Mohamed Ali on 29/03/2024.
//

import Foundation
import Moya

enum MoviesApi {
    case PopularMovie(page: Int)
}

extension MoviesApi: TargetType {
    
   var baseURL: URL {
       guard let url = URL(string: AppConstants.baseURL) else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .PopularMovie(_):
            "/popular"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .PopularMovie(_):
                .get
        }
    }
    
    var task: Moya.Task {
        var parameters: [String: Any] =  ["api_key": AppConstants.apiKey]
        switch self {
        case .PopularMovie(let page):
            parameters["page"] = page
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["accept": "application/json"]
    }
}
