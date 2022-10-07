//
//  APITests.swift
//  EtraveliAssignmentTests
//
//  Created by Iason Michailidis on 3/10/22.
//

import XCTest
@testable import EtraveliAssignment

final class APITestCase: XCTestCase {
    
    let key = OMDB.key
    let baseUrl = URL(string: OMDB.baseURLString)
    let id = "tt0082971"
    let title = "Indiana Jones"
    
    func test_baseURL_notNil() {
        XCTAssertNotNil(baseUrl)
    }
    
    func test_request_toBaseURL() {
        let expectation = expectation(description: #function)
        let request = URLRequest(url: baseUrl!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: 5)
    }
    
    func test_request_byId_NoKey() {
        let expectation = expectation(description: #function)
        let query = "?i=\(id)"
        let queryUrl = URL(string: query, relativeTo: baseUrl)
        XCTAssertNotNil(queryUrl)
        let request = URLRequest(url: queryUrl!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            let urlResponse = response as? HTTPURLResponse
            XCTAssertEqual(urlResponse?.statusCode, 401)
            expectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: 5)
    }
    
    func test_request_byId_WithKey() {
        let expectation = expectation(description: #function)
        let query = "?i=\(id)&apikey=\(key)"
        let queryUrl = URL(string: query, relativeTo: baseUrl)
        XCTAssertNotNil(queryUrl)
        let request = URLRequest(url: queryUrl!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            let urlResponse = response as? HTTPURLResponse
            XCTAssertEqual(urlResponse?.statusCode, 200)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: 5)
    }
    
    func test_request_byTitle_WithKey() {
        let expectation = expectation(description: #function)
        let query = "?s=\(title)&apikey=\(key)"
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        XCTAssertNotNil(encodedQuery)
        let queryUrl = URL(string: encodedQuery!, relativeTo: baseUrl)
        XCTAssertNotNil(queryUrl)
        let request = URLRequest(url: queryUrl!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            let urlResponse = response as? HTTPURLResponse
            XCTAssertEqual(urlResponse?.statusCode, 200)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: 5)
    }
    
}
