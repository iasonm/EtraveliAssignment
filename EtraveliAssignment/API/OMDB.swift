//
//  OMDB.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 3/10/22.
//

import Foundation

struct OMDB {

    enum MediaType: String {
        case movie, series, episode
    }
    
    enum PlotType: String {
        case short, full
    }
    
    static let baseURLString = "http://www.omdbapi.com"
    static let key = "93b1cf30"
    
}
