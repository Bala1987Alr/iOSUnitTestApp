//
//  DetailViewController.swift
//  TestApp
//
//  Created by Balasubramanian M on 20/10/19.
//  Copyright © 2019 Balasubramanian M. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var infoMap: MKMapView!
    
    func configureView() {
        
        loadViewIfNeeded()
        let id = String(detailItem!._id)
        
        let location2D = CLLocationCoordinate2D(latitude: (detailItem?.coord.lat)!, longitude: (detailItem?.coord.lon)!)
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let coordinateRegion = MKCoordinateRegion(center: location2D, span: coordinateSpan)
        infoMap.setRegion(coordinateRegion, animated: true)
        
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = location2D
        mapAnnotation.title = detailItem!.name + ", "+detailItem!.country
        mapAnnotation.subtitle = id
        infoMap.addAnnotation(mapAnnotation)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    var detailItem: City? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

