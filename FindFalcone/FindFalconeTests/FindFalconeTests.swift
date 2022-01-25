//
//  FindFalconeTests.swift
//  FindFalconeTests
//
//  Created by Nguyen Ngoc Diep on 2022/01/23.
//

import XCTest
import FalconeCore

@testable import FindFalcone

class FindFalconeTests: XCTestCase {

    var presenter: SearchFalconePresenter!
    var service: GetUserTokenService!
    var findFalconeService: FindFalconeService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        presenter =  SearchFalconePresenter()
        service = GetUserTokenService()
        findFalconeService = FindFalconeService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testGetTokenPlanet() throws {
        let promise = expectation(description: "Completion handler invoked")
        service.getUserToken()
            .cloudResponse({ [weak self] token in
                self?.presenter.token = token.token ?? ""
            })
            .finally {
            promise.fulfill()
        }

        wait(for: [promise], timeout: 30)
        XCTAssertNotEqual(presenter.token, "")
    }

    func testGetPlanets() throws {
        let promise = expectation(description: "Completion handler invoked")
        findFalconeService.getPlanets().cloudResponse { [weak self] collection in
            self?.presenter.planets = collection.items
        }.finally {
            promise.fulfill()
        }

        wait(for: [promise], timeout: 30)
        XCTAssertNotEqual(presenter.planets.count, 0)
    }

    func testGetVehicles() throws {
        let promise = expectation(description: "Completion handler invoked")
        findFalconeService.getVehicles().cloudResponse { [weak self] collection in
            self?.presenter.vehicles = collection.items
        }.finally {
            promise.fulfill()
        }

        wait(for: [promise], timeout: 30)
        XCTAssertNotEqual(presenter.vehicles.count, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
