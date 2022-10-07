//
//  ImageStoreTestCase.swift
//  EtraveliAssignmentTests
//
//  Created by Iason Michailidis on 5/10/22.
//

import XCTest
@testable import EtraveliAssignment

final class ImageStoreTestCase: XCTestCase {
    
    func test_ImageStore() {
        XCTAssertNotNil(UIImage(named: "eyeSlashSquare"))
        XCTAssertNotNil(UIImage(named: "eyeSlashRect"))
    }
}
