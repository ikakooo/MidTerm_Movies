//
//  MoviesDataManager.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 24.10.21.
//

import Foundation


class MoviesDataManager {
    
    private var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getMovies(page:Int,completion: @escaping ((MovieDataModel) -> Void)) {
        let queries = ["api_key": MovieConstants.API_KEY,"page":"\(page)"]
        
        networkManager.get(url: MovieConstants.BASE_URL_MOVIES, path: MovieConstants.popularMoviesPath , queryParams: queries) { (result: Result<MovieDataModel, Error>) in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse)
            case .failure(let error):
                print("\(error) ikakooooooooo")
            }
        }
    }
    
    func SearchMoviesBy(Name:String,completion: @escaping ((MovieDataModel) -> Void)) {
        let queries = ["api_key": MovieConstants.API_KEY,"query":"\(Name)"]
        
        networkManager.get(url: MovieConstants.BASE_URL_MOVIES, path: MovieConstants.searchMoviesPath , queryParams: queries) { (result: Result<MovieDataModel, Error>) in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse)
            case .failure(let error):
                print("\(error) ikakooooooooo")
            }
        }
    }
}
