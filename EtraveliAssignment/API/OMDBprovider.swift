//
//  OMDBprovider.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 7/10/22.
//

import Foundation

protocol OMDBprovider {
    func searchByTitle(_ title: String, completion: @escaping (Result<[MoviesData], Error>) -> Void)
    func searchById(id: String, completion: @escaping (Result<MoviesData, Error>) -> Void)
}

