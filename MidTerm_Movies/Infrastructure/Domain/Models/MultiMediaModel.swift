//
//  MultiMediaModel.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 26.10.21.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let multiMediaModel = try? newJSONDecoder().decode(MultiMediaModel.self, from: jsonData)

import Foundation

// MARK: - MultiMediaModel
struct MultiMediaModel: Codable {
    let page: Int?
    let results: [Media]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Media
struct Media: Codable {
    let backdropPath: String?
    let firstAirDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let mediaType: MediaType
    let name: String?
    let originCountry: [String]?
    let originalLanguage: OriginalLanguage?
    let originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    let adult: Bool?
    let originalTitle, releaseDate, title: String?
    let video: Bool?
    let gender: Int?
    let knownFor: [Media]?
    let knownForDepartment, profilePath: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case title, video, gender
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case de = "de"
    case en = "en"
    case hi = "hi"
    case ka = "ka"
    case Unknown
}

