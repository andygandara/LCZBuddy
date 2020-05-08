//
//  DetailViewController.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/16/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class DetailViewController: UIViewController {
    @IBOutlet var lczTypeLabel: UILabel!
    @IBOutlet var coordinatesLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var photosCollectionView: UICollectionView!
    
    let lczService = LCZService()
    
    var model: LCZ? = nil
    var images: [UIImage]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bind(data: model)
        fetchImages()
    }
    
    func setupCollectionView() {
        photosCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        photosCollectionView.register(UINib(nibName: "EmptyPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmptyPhotoCollectionViewCell")
        photosCollectionView.layer.cornerRadius = 8
    }
    
    func setMap(with lcz: LCZ) {
        let coordinate = CLLocationCoordinate2D(latitude: lcz.location.latitude,
                                                longitude: lcz.location.longitude)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Type " + lcz.lczType.name
        annotation.subtitle = lcz.location.formatted()
        self.mapView.addAnnotation(annotation)
    }
    
    func fetchImages() {
        guard let id = model?.id else { return }
        lczService.fetchImages(id: id) { images in
            guard let images = images else { return }
            self.images = images
            self.photosCollectionView.reloadData()
        }
    }
    
    func bind(data: LCZ?) {
        guard let data = data else { return }
        
        self.title = data.cityState
        lczTypeLabel.text = "Type \(data.lczType.name)"
        coordinatesLabel.text = data.location.formatted()
        setMap(with: data)
    }

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.bind(data: images?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 600)
    }
}
