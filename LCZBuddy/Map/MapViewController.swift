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
    
    private var lczs: [LCZ] = []
    
    private let lczService = LCZService()
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupLocationManager()
        setPlacemarks()
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func setPlacemarks() {
        lczService.fetchLCZs { lczs in
            guard let lczs = lczs else { return }
            lczs.forEach {
                let coordinate = CLLocationCoordinate2D(latitude: $0.location.latitude,
                                                        longitude: $0.location.longitude)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "Type " + $0.lczType.name
                annotation.subtitle = $0.location.formatted()
                self.mapView.addAnnotation(annotation)
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        defer { currentLocation = userLocation.location }
        if currentLocation == nil {
            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            let region = MKCoordinateRegion(center: userLocation.coordinate,
                                            span: span)
            mapView.setRegion(region, animated: false)
        }
    }
}
