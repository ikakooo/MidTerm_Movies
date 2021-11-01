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
    
    func getMovies(page:Int,path:String, completion: @escaping ((MovieDataModel) -> Void)) {
        let queries = ["api_key": MovieConstants.API_KEY,"page":"\(page)"]
        
        networkManager.get(url: MovieConstants.BASE_URL_MOVIES, path: path , queryParams: queries) { (result: Result<MovieDataModel, Error>) in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse)
            case .failure(let error):
                print("\(error) ikakooooooooo")
            }
        }
    }
    
    func getPopularMovies(page:Int,completion: @escaping ((MovieDataModel) -> Void)) {
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
    
    func getNewMovies(page:Int,completion: @escaping ((MovieDataModel) -> Void)) {
        let queries = ["api_key": MovieConstants.API_KEY,"page":"\(page)"]
        
        networkManager.get(url: MovieConstants.BASE_URL_MOVIES, path: MovieConstants.newMoviesPath , queryParams: queries) { (result: Result<MovieDataModel, Error>) in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse)
            case .failure(let error):
                print("\(error) ikakooooooooo")
            }
        }
    }
    func getNowPlayingMovies(page:Int,completion: @escaping ((MovieDataModel) -> Void)) {
        let queries = ["api_key": MovieConstants.API_KEY,"page":"\(page)"]
        
        networkManager.get(url: MovieConstants.BASE_URL_MOVIES, path: MovieConstants.nowPlayingMoviesPath , queryParams: queries) { (result: Result<MovieDataModel, Error>) in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse)
            case .failure(let error):
                print("\(error) ikakooooooooo")
            }
        }
    }
    
    func getTopRatedMovies(page:Int,completion: @escaping ((MovieDataModel) -> Void)) {
        let queries = ["api_key": MovieConstants.API_KEY,"page":"\(page)"]
        
        networkManager.get(url: MovieConstants.BASE_URL_MOVIES, path: MovieConstants.topRatedMoviesPath , queryParams: queries) { (result: Result<MovieDataModel, Error>) in
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
    
    func MultiMediaSearchBy(Name:String,completion: @escaping ((MultiMediaModel) -> Void)) {
        let queries = ["api_key": MovieConstants.API_KEY,"query":"\(Name)"]
        
        networkManager.get(url: MovieConstants.BASE_URL_MOVIES, path: MovieConstants.multiSearchPath , queryParams: queries) { (result: Result<MultiMediaModel, Error>) in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse)
            case .failure(let error):
                print("\(error) ikakooooooooo")
            }
        }
    }
    
    func TvShowSearchBy(Name:String,completion: @escaping ((TVShowsModel) -> Void)) {
        let queries = ["api_key": MovieConstants.API_KEY,"query":"\(Name)"]
        
        networkManager.get(url: MovieConstants.BASE_URL_MOVIES, path: MovieConstants.multiSearchPath , queryParams: queries) { (result: Result<TVShowsModel, Error>) in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse)
            case .failure(let error):
                print("\(error) ikakooooooooo")
            }
        }
    }
}
