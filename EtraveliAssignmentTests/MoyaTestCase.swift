//
//  MoyaTestCase.swift
//  EtraveliAssignmentTests
//
//  Created by Iason Michailidis on 3/10/22.
//

import XCTest
import Moya
@testable import EtraveliAssignment

final class MoyaTestCase: XCTestCase {
    
    let provider = MoyaProvider<API>()
    let id = "tt0082971"
    let title = "Indiana Jones"
    let invalidTitle = "kdfle0i3m"
    
    func test_titleSearch_withValidTitle() {
        let expectation = expectation(description: #function)
        provider.request(.titleSearch(title: title)) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200, "Response for title search: \(response.statusCode)")
                let data = response.data
                let decoder = JSONDecoder()
                do {
                    let moviesSearchData = try decoder.decode(MoviesSearchData.self, from: data)
                    if !moviesSearchData.validResponse {
                        XCTFail("There was no data in the response to a valid search")
                    }
                    if let resultArr = moviesSearchData.Search {
                        XCTAssertGreaterThanOrEqual(resultArr.count, 3, "There are at least 3 Indiana Jones movies...")
                    } 
                } catch {
                    XCTFail("Couldn't decode title search data: \(error.localizedDescription)")
                }
            case .failure(let error):
                XCTFail("Request titleSearch failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_titleSearch_withInvalidTitle() {
        let expectation = expectation(description: #function)
        provider.request(.titleSearch(title: invalidTitle)) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200, "Response for title search: \(response.statusCode)")
                let data = response.data
                let decoder = JSONDecoder()
                do {
                    let moviesSearchData = try decoder.decode(MoviesSearchData.self, from: data)
                    print(moviesSearchData, moviesSearchData.validResponse)
                    if moviesSearchData.validResponse {
                        XCTFail("There should be no data in the response")
                    }
                    if let resultArr = moviesSearchData.Search {
                        XCTAssertEqual(resultArr.count, 0, "No results expected")
                    } else {
                        XCTAssertNil(moviesSearchData.Search)
                    }
                } catch {
                    XCTFail("Couldn't decode title search data: \(error.localizedDescription)")
                }
            case .failure(let error):
                XCTFail("Request titleSearch failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_titleSearch_withPage_invalidTitle() {
        let expectation = expectation(description: #function)
        provider.request(.titleSearch(title: invalidTitle)) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200, "Response for title search: \(response.statusCode)")
                let data = response.data
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(MoviesSearchData.self, from: data)
                    if let resultArr = decoded.Search {
                        XCTAssertEqual(resultArr.count, 0, "No results expected")
                    } else {
                        XCTAssertNil(decoded.Search)
                    }
                } catch {
                    XCTFail("Couldn't decode title search data: \(error.localizedDescription)")
                }
            case .failure(let error):
                XCTFail("Request titleSearch failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_idSearch_validId() {
        let expectation = expectation(description: #function)
        provider.request(.idSearch(id: id)) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200, "Response for id search: \(response.statusCode)")
                let data = response.data
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(MoviesData.self, from: data)
                    XCTAssertEqual(decoded.Title, "Indiana Jones and the Raiders of the Lost Ark", "Wrong movie retrieved")
                } catch {
                    XCTFail("Couldn't decode id search data: \(error.localizedDescription)")
                }
            case .failure(let error):
                XCTFail("Request idSearch failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func test_idSearch_invalidId() {
        let expectation = expectation(description: #function)
        provider.request(.idSearch(id: "45ni2")) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200, "Response for id search: \(response.statusCode)")
                let data = response.data
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(MoviesData.self, from: data)
                    XCTAssertNil(decoded.imdbID, "Invalid id should return imdbID nil")
                } catch {
                    XCTFail("Couldn't decode id search data: \(error.localizedDescription)")
                }
            case .failure(let error):
                XCTFail("Request idSearch failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
