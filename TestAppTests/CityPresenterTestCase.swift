//
//  CityPresenterTestCase.swift
//  TestAppTests
//
//  Created by Balasubramanian M on 21/10/19.
//  Copyright © 2019 Balasubramanian M. All rights reserved.
//

import XCTest
@testable import TestApp

class CityPresenterTestCase: XCTestCase {

    private var cityRepositoryWithCitiesSpy : CityRepositoryWithCitiesSpy!
    private var cityRepositoryWithOutCitiesSpy : CityRepositoryWithOutCitiesSpy!
    private var cityParsingViewSpy : CityParsingViewSpy!
    private var cityParsingPresenter : CityParsingPresenter!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWithCities()
    {
        getRepoWithCities()
        getCityparsingView()
        displayCitiesWithPresenter(repository: cityRepositoryWithCitiesSpy)
        startUpdatePresenter()
        
    }
    
    func testWithOutCities()
    {
        getRepoWithOutCities()
        getCityparsingView()
        displayCitiesWithPresenter(repository: cityRepositoryWithCitiesSpy)
        startUpdatePresenter()
        
    }
    
    private func getRepoWithCities()
    {
        cityRepositoryWithCitiesSpy = CityRepositoryWithCitiesSpy()
    }
    
    private func getRepoWithOutCities()
    {
        cityRepositoryWithOutCitiesSpy = CityRepositoryWithOutCitiesSpy()
    }
    
    private func getCityparsingView()
    {
        cityParsingViewSpy = CityParsingViewSpy()
    }
    private func displayCitiesWithPresenter(repository : Repository)
    {
        cityParsingPresenter = CityParsingPresenter(cityParsingView: cityParsingViewSpy, cityRepository: repository as! CityRepository)
    }
    private func startUpdatePresenter()
    {
         let url = Bundle.main.path(forResource: "cities", ofType: "json")
         cityParsingPresenter.parseCityJSON(path: url!)
    }
    private func showActivityIndicator()
    {
        XCTAssertTrue(cityParsingViewSpy.showLoadingStatusHasBeenCalled)
    }
    private func hideActivityIndicator()
    {
        XCTAssertTrue(cityParsingViewSpy.hideLoadingStatusHasBeenCalled)
    }
    private func disPlayCities()
    {
        XCTAssertTrue(cityParsingViewSpy.showListOfcityHasBeenCalled)
    }

}
