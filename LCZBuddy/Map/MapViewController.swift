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
    
    var lczs: [LCZ] = []
    
    let lczService = LCZService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlacemarks()
    }
    
    func setPlacemarks() {
        lczService.fetch { lczs in
            guard let lczs = lczs else { return }
            lczs.forEach {
                let coordinate = CLLocationCoordinate2D(latitude: $0.location.latitude,
                                                        longitude: $0.location.longitude)
                let placemark = MKPlacemark(coordinate: coordinate)
                self.mapView.addAnnotation(placemark)
            }
        }
    }
    
}
