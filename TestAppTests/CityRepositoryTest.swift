//
//  CityRepositoryTest.swift
//  TestAppTests
//
//  Created by Balasubramanian M on 21/10/19.
//  Copyright © 2019 Balasubramanian M. All rights reserved.
//

import XCTest
@testable import TestApp

class CityRepositoryTest: XCTestCase {

    var cityRepository : CityRepository!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        givenACityRepository()
        whenRepoTryToRetriveCity {
            [unowned self] city, repositoryExpectation in
            self.thenCityListIsRetrieved(city: city, expectation: repositoryExpectation)
       
        }
        thenTheRepositoryFinishedToTryToRetrieve()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func givenACityRepository()
    {
        cityRepository = CityRepository()
    }
    
    func whenRepoTryToRetriveCity(finish: @escaping ([City]?, XCTestExpectation) -> Void)
    {
        let repoExpec = expectation(description: "Repository expectation")
        cityRepository.get
        {
            city in finish(city,repoExpec)
        }
    }
    
    private func thenCityListIsRetrieved(city: [City]?, expectation: XCTestExpectation) {
            print(city!.count)
            XCTAssertNotNil(city)
            XCTAssertTrue(city!.count > 0)
            expectation.fulfill()
    }
    private func thenTheRepositoryFinishedToTryToRetrieve() {
            waitForExpectations(timeout: 10) { error in
                if let error = error {
                    XCTFail("Repository finish() not called: \(error)")
                }
            }
        }


}
