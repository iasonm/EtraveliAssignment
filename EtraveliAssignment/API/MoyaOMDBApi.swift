//
//  OMDBApi.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 3/10/22.
//

import Foundation
import Moya

enum API {
    case titleSearch(title: String)
    case idSearch(id: String)
}

extension API: TargetType {
    
    var baseURL: URL { URL(string: OMDB.baseURLString)! }
    var path: String {
        switch self {
        case .titleSearch: return "/"
        case .idSearch: return "/"
        }
    }
    var method: Moya.Method {
        switch self {
        case .titleSearch, .idSearch: return .get
        }
    }
    var task: Task {
        let type = OMDB.MediaType.movie.rawValue
        let key = OMDB.key
        let plotType = OMDB.PlotType.full.rawValue
        switch self {
        case .titleSearch(let title):
            return .requestParameters(parameters: ["s":title, "type":type, "apikey":key], encoding: URLEncoding.queryString)
        case .idSearch(let id):
            return .requestParameters(parameters: ["i":id, "plot":plotType, "type":type, "apikey":key], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return Data("sample".utf8)
    }
    
}



class MoyaOMDBApi: OMDBprovider {

    let provider = MoyaProvider<API>()
        
    func searchByTitle(_ title: String, completion: @escaping (Result<[MoviesData], Error>) -> Void) {
        provider.request(.titleSearch(title: title)) { result in
            switch result {
            case .success(let response):
                let data = response.data
                let decoder = JSONDecoder()
                do {
                    let moviesSearchData = try decoder.decode(MoviesSearchData.self, from: data)
                    completion(.success(moviesSearchData.moviesArray))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchById(id: String, completion: @escaping (Result<MoviesData, Error>) -> Void) {
        provider.request(.idSearch(id: id)) { result in
            switch result {
            case .success(let response):
                let data = response.data
                let decoder = JSONDecoder()
                do {
                    let moviesData = try decoder.decode(MoviesData.self, from: data)
                    moviesData.imdbID == nil ? completion(.failure(OMDBError.invalidId)) : completion(.success(moviesData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}

enum OMDBError: Error {
    case noData, invalidId
}

extension OMDBError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noData: return "No data returned from server"
        case .invalidId: return "Invalid id provided"
        }
    }
}

