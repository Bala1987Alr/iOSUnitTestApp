//
//  City.swift
//  TestApp
//
//  Created by Balasubramanian M on 20/10/19.
//  Copyright © 2019 Balasubramanian M. All rights reserved.
//

import Foundation

struct City : Codable {
    
    var country : String
    let name : String
    var _id : Int
    var coord : coord
    
}

struct coord: Codable {
    var lon : Double
    var lat : Double
}

protocol Repository {
    func get(finish: @escaping ([City]?) -> Void)
}

public class CityRepository : Repository
{
    var cityList = [City]()
    func get(finish: @escaping ([City]?) -> Void) {
        
        DispatchQueue.main.async {
            do{
            if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
                let citydata = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                self.cityList = try jsonDecoder.decode([City].self, from: citydata)
                self.cityList = self.cityList.sorted(by: { $0.name < $1.name })
                finish(self.cityList)
            }
            }catch
            {
                print("Error")
            }
        }
        
    }
    
}

protocol CityParsingView
{
    func showActivityIndicator()
    func hideActivityIndicator()
    func parsingSuccess(cityList:[City])
    func parsingFailed(error : Error)
    
}

class CityParsingPresenter
{
    var cityParsingView : CityParsingView!
    var repository : Repository!
    var cityList = [City]()
    
    init(cityParsingView : CityParsingView, repository: Repository) {
        self.cityParsingView = cityParsingView
        self.repository =  repository
    }
    
    func parseCityJSON(path: String) {
        
            cityParsingView.showActivityIndicator()
            repository.get{
            
                cityList in self.cityParsingView.parsingSuccess(cityList: cityList!)
                
            }
            cityParsingView.hideActivityIndicator()
        
    }
}
