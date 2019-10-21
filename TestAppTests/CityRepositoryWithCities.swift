//
//  CityRepositoryWithCities.swift
//  TestAppTests
//
//  Created by Balasubramanian M on 21/10/19.
//  Copyright © 2019 Balasubramanian M. All rights reserved.
//

import Foundation
@testable import TestApp

class CityRepositoryWithCitiesSpy : Repository {
    
    var cityList = [City]()
    
    func get(finish: @escaping ([City]?) -> Void) {
        
        let coordinate1 =  coord(lon: 21.55444,lat: 23.454646)
        let coordinate2 =  coord(lon: 21.55444,lat: 23.454646)
    
        let city1 = City(country: "IN", name: "Chennai", _id: 213131, coord: coordinate1)
        let city2 = City(country: "US", name: "New Jersy", _id: 213131, coord: coordinate2)
        
        cityList.append(city1)
        cityList.append(city2)
        
        finish(cityList)
    }
    
}

class CityRepositoryWithOutCitiesSpy : Repository {
    
    var cityList = [City]()
    private(set) var getHasBeenCalled: Bool = false
    
    func get(finish: @escaping ([City]?) -> Void) {
    
        getHasBeenCalled = true
        finish(nil)
    }
    
}

class CityParsingViewSpy : CityParsingView
{
    private(set) var showLoadingStatusHasBeenCalled: Bool = false
    private(set) var hideLoadingStatusHasBeenCalled: Bool = false
    private(set) var showListOfcityHasBeenCalled: Bool = false
    private(set) var showsErrorMessageHasBeenCalled: Bool = false
    
    
    func showActivityIndicator() {
        showLoadingStatusHasBeenCalled = true
    }
    
    func hideActivityIndicator() {
        hideLoadingStatusHasBeenCalled = true
    }
    
    func parsingSuccess(cityList: [City]) {
        showListOfcityHasBeenCalled = true
    }
    
    func parsingFailed(error: Error) {
        showsErrorMessageHasBeenCalled = true
    }
    
    
}

