//
//  Iablonskyi_Ievgenii_Test_TaskTests.swift
//  Iablonskyi Ievgenii Test TaskTests
//
//  Created by тигренок  on 10/09/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import Iablonskyi_Ievgenii_Test_Task

class Iablonskyi_Ievgenii_Test_TaskTests: XCTestCase {
    
    var salonsVC: SalonsViewController!
    var model: Model?
    
    override func setUp() {
        super.setUp()
        setUpSalonsVC()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTableViewShowedProperly() {
        let _ = salonsVC.view // triggers View's methods.
        XCTAssertTrue(salonsVC.salonsTableView != nil, "The table view should be set")
        let expectation = expectationWithDescription("Alamofire")
        model!.getDataFromUrl(Constants.APIUrl) { (parsedSalons) in
            XCTAssertNotNil(parsedSalons, "parsedSalons should not be nil")
            let numberOfCells = self.salonsVC.salonsTableView.numberOfRowsInSection(0)
            XCTAssert(numberOfCells == parsedSalons!.count, "Number of cells should have the same as a number of parsed salons")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    // Set up all stuff that we need.
    private func setUpSalonsVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        UIApplication.sharedApplication().keyWindow?.rootViewController = navigationController
        salonsVC = navigationController?.viewControllers.first as! SalonsViewController
        model = Model()
        sleep(1) // prevents occasional test failures.
    }

    
    
}
