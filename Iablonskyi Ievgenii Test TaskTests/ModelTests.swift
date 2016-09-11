//
//  Model Tests.swift
//  Iablonskyi Ievgenii Test Task
//
//  Created by тигренок  on 10/09/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import Iablonskyi_Ievgenii_Test_Task


class ModelTests: XCTestCase {
    
    // MARK: - Variabels
    var model: Model?
    
    // MARK: - Tests lifecycle
    override func setUp() {
        super.setUp()
        model = Model()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    func testGetDataFromUrl() {
        let expectation = expectationWithDescription("API Test")
        model!.getDataFromUrl(Constants.APIUrl) { isSuccess, parsedSalons in
            XCTAssertTrue(isSuccess, "Response failure")
            XCTAssertNotNil(parsedSalons, "ParsedSalons should not be nil")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
}
