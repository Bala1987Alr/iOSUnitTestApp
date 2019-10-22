//
//  MasterViewController.swift
//  TestApp
//
//  Created by Balasubramanian M on 20/10/19.
//  Copyright © 2019 Balasubramanian M. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var cityList = [City]()
    var filterdCity = [City]()
    let searchCityController = UISearchController(searchResultsController: nil)
    var cityParsingPresenter : CityParsingPresenter?
    var cityRepository = CityRepository()
    var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityParsingPresenter = CityParsingPresenter(cityParsingView: self,repository: cityRepository)
        
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            self.cityParsingPresenter?.parseCityJSON(path: path)
        }
        
        // Do any additional setup after loading the view.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        searchCityController.searchResultsUpdater = self
        searchCityController.obscuresBackgroundDuringPresentation = false
        searchCityController.searchBar.placeholder = "Search city"
        navigationItem.searchController = searchCityController
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                if(searchCityController.isActive)
                {
                controller.detailItem = filterdCity[indexPath.row]
                }
                else{
                controller.detailItem = cityList[indexPath.row]
                }
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if(searchCityController.isActive)
        {
             return filterdCity.count
        }
        else
        {
            return cityList.count
        }
           
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityTableViewCell
        
        if(searchCityController.isActive){
            let city = filterdCity[indexPath.row]
            let id = String(city._id)
            cell.country.text = city.name+", "+city.country+", "+id
            cell.latlong.text = String(format:"%f", city.coord.lat)+","+String(format:"%f", city.coord.lon)
        }else{
            let city = cityList[indexPath.row]
            let id = String(city._id)
            cell.country.text = city.name+", "+city.country+", "+id
            cell.latlong.text = String(format:"%f", city.coord.lat)+","+String(format:"%f", city.coord.lon)
        }
        return cell
        
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}
extension MasterViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
        else
        {
            self.tableView.reloadData()
            return
        }
        
        if(searchCityController.isActive && searchController.searchBar.text!.isEmpty)
        {
            print("is Empty")
            filterdCity = cityList
            tableView.reloadData()
        }
        else
        {
            filterdCity = cityList.filter({city -> Bool in
                       city.name.lowercased().starts(with: text.lowercased())
                   })
        }
        tableView.reloadData()
    }
}

extension MasterViewController : CityParsingView
{
    
    func showActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center =  self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator() {
        
        if(activityIndicator.isAnimating)
        {
            activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    func parsingSuccess(cityList: [City]) {
        self.cityList =  cityList
        print("inside : %d", self.cityList.count)
        tableView.reloadData()
    }
    
    func parsingFailed(error: Error) {
        print(error.localizedDescription)
    }
    
    
}


