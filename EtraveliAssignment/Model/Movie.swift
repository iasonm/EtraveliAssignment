//
//  Movie.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 3/10/22.
//

import Foundation

struct Movie {
    
    init(moviesData: MoviesData) {
        self.id = moviesData.imdbID.emptyOnNil
        self.title = moviesData.Title.emptyOnNil
        self.year = moviesData.Year.emptyOnNil
        self.director = moviesData.Director.emptyOnNil
        self.actors = moviesData.Actors.emptyOnNil
        self.plot = moviesData.Plot.emptyOnNil
        self.poster = moviesData.Poster.emptyOnNil
        if let ratings = moviesData.Ratings {
            self.ratings = ratings.map { Ratings(source: $0.Source.emptyOnNil, value: $0.Value.emptyOnNil)}
        } else {
            self.ratings = []
        }
    }
    
    let id: String
    let title: String
    let year: String
    let director: String
    let actors: String
    let plot: String
    let poster: String
    let ratings: [Ratings]
    
    var ratingsText: String {
        var result = ""
        for rating in ratings {
            result += rating.line + "\n"
        }
        return result
    }
}

struct Ratings {
    
    let source: String
    let value: String
    
    var line: String {
        return "\(source): \(value)"
    }
}

