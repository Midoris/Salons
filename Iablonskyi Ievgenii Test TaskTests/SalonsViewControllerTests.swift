//
//  Iablonskyi_Ievgenii_Test_TaskTests.swift
//  Iablonskyi Ievgenii Test TaskTests
//
//  Created by тигренок  on 10/09/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import XCTest
@testable import Iablonskyi_Ievgenii_Test_Task

class SalonsViewControllerTests: XCTestCase {
    
    // MARK: - Variabels
    var salonsVC: SalonsViewController!
    
    // MARK: - Tests lifecycle
    override func setUp() {
        super.setUp()
        setUpSalonsVC()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    func testTableViewShowedProperly() {
        XCTAssertTrue(salonsVC.salonsTableView != nil, "The table view should be set")
        let expectation = expectationWithDescription("Table View Test")
        salonsVC.model.getDataFromUrl(Constants.APIUrl) { _, parsedSalons in
            let numberOfCells = self.salonsVC.salonsTableView.numberOfRowsInSection(0)
            XCTAssertTrue(numberOfCells == parsedSalons!.count, "Number of cells should have the same as a number of parsed salons")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    // MARK: - Methods
    // Set up all stuff that we need.
    private func setUpSalonsVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        UIApplication.sharedApplication().keyWindow?.rootViewController = navigationController
        salonsVC = navigationController?.viewControllers.first as! SalonsViewController
        let _ = salonsVC.view // triggers View's methods.
        sleep(1) // prevents occasional test failures.
    }

    
    
}
