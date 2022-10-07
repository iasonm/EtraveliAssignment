//
//  MoviesData.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 4/10/22.
//

import Foundation

struct MoviesSearchData: Codable {
    let Search: [MoviesData]?
    let totalResults: String?
    let Response: String?
    let Error: String?
    
    var moviesArray: [MoviesData] {
        Search == nil ? [] : Search!
    }
    
    var validResponse: Bool {
        if let Response = Response {
            return Response == "True"
        } else {
            return false
        }
    }
}

struct MoviesData: Codable {
    let imdbID: String?
    let Title: String?
    let Year: String?
    let Director: String?
    let Actors: String?
    let Plot: String?
    let Poster: String?
    let Ratings: [MovieRatings]?
    let Response: String?
    let Error: String?
    
    var validResponse: Bool {
        if let Response = Response {
            return Response == "True"
        } else {
            return false
        }
    }
}

struct MovieRatings: Codable {
    let Source: String?
    let Value: String?
}
