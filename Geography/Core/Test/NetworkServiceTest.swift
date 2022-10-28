//
//  NetworkTest.swift
//  GeographyTests
//
//  Created by Kevin Dieu on 10/11/22.
//

import XCTest
@testable import Geography

final class NetworkServiceTest: XCTestCase {
    func testEmptyResponse() {
        NetworkService().loadData(from: "") { result in
            switch result {
            case .success(_):
                XCTAssertFalse(true)
                break
            case .failure(let error):
                XCTAssertEqual(error, .badUrl)
                break
            }
        }
    }
    func testBadResponse() {
        let expectation = expectation(description: "NetworkService - test the url sesion retriving the data")

        NetworkService().loadData(from: "www.valid-url.com") { result in
            switch result {
            case .success(let data):
                XCTAssertFalse(true)

                break
            case .failure(let error):
                XCTAssertEqual(error, .badResponse)
                expectation.fulfill()

                break
            }
        }
        waitForExpectations(timeout: 1) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
          }
        }
    }
}
// https://betterprogramming.pub/unit-testing-asynchronous-combine-code-using-xctest-framework-3066f570f200

/// Mock the correct response by gettting the correct AnyPublisher.Output. So Getting the return
/// URLSession.DataTaskPublisher.Outpiut
/// Use 
