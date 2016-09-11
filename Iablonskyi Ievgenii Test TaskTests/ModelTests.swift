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
    
    var model: Model?
    
    override func setUp() {
        super.setUp()
        model = Model()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetDataFromUrl() {
        let expectation = expectationWithDescription("Alamofire")
        model!.getDataFromUrl(Constants.APIUrl) { parsedSalons in
            XCTAssertNotNil(parsedSalons, "parsedSalons should not be nil")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
}
