//
//  DetailViewController.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/16/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    @IBOutlet var lczTypeLabel: UILabel!
    @IBOutlet var coordinatesLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    var model: LCZModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(data: model)
    }
    
    func setMap(with location: CLLocationCoordinate2D) {
        let center = CLLocationCoordinate2D(latitude: location.latitude,
                                            longitude: location.longitude)
        let region = MKCoordinateRegion(center: center,
                                        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.setRegion(region, animated: true)
        let placemark = MKPlacemark(coordinate: location)
        mapView.addAnnotation(placemark)
    }
    
    func bind(data: LCZModel?) {
        guard let data = data else { return }
        
        self.title = data.cityState
        lczTypeLabel.text = "Type \(data.lczType.name)"
        coordinatesLabel.text = data.location.formatted()
        setMap(with: data.location)
    }

}
