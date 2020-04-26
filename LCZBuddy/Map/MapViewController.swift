//
//  MapViewController.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/13/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    var lczs: [LCZModel] = []
    
    let lczService = LCZService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlacemarks()
    }
    
    func setPlacemarks() {
        lczService.fetchLCZs().forEach {
            let placemark = MKPlacemark(coordinate: $0.location)
            mapView.addAnnotation(placemark)
        }
    }
    
}
