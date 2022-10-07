//
//  ExtensionTestCase.swift
//  EtraveliAssignmentTests
//
//  Created by Iason Michailidis on 5/10/22.
//

import XCTest
@testable import EtraveliAssignment

final class ExtensionTestCase: XCTestCase {

    func test_addSubviews() {
        let mainView = UIView()
        let firstView = UIView()
        let secondView = UIView()
        let thirdView = UIView()
        XCTAssertEqual(mainView.subviews.count, 0)
        XCTAssertEqual(firstView.translatesAutoresizingMaskIntoConstraints, true)
        XCTAssertEqual(secondView.translatesAutoresizingMaskIntoConstraints, true)
        XCTAssertEqual(thirdView.translatesAutoresizingMaskIntoConstraints, true)
        
        mainView.addSubviews([firstView, secondView, thirdView])
        XCTAssertEqual(mainView.subviews.count, 3)
        XCTAssertEqual(firstView.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(secondView.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(thirdView.translatesAutoresizingMaskIntoConstraints, false)
    }
    
    
}
