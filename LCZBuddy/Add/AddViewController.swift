//
//  AddViewController.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/13/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var latitudeTextField: UITextField!
    @IBOutlet var longitudeTextField: UITextField!
    @IBOutlet var getLocationButton: UIButton!
    @IBOutlet var lczPickerView: UIPickerView!
    @IBOutlet var photosCollectionView: UICollectionView!
    @IBOutlet var addPhotosButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var informationLabel: UILabel!
    var spinner: UIView?
    
    let lczPickerData: [String] = LCZType.allCases.compactMap { "Type \($0.name)" }
    
    let lczService = LCZService()
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var currentCoordinates: CLLocationCoordinate2D?
    var currentCityState: String?
    var images: [UIImage] = [] {
        didSet { photosCollectionView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        photosCollectionView.register(UINib(nibName: "EmptyPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmptyPhotoCollectionViewCell")
        photosCollectionView.layer.cornerRadius = 8
        informationLabel.text = "Add 4 photos in each of the cardinal directions: north, south, east, and west."
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getLocationButtonPressed(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func helpButtonPressed(_ sender: Any) {
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        
        let actionSheet = UIAlertController(title: "Select photo source", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            vc.sourceType = .camera
            self.present(vc, animated: true)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { _ in
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        getLCZModel { [weak self] model in
            guard let model = model else {
                self?.showErrorAlert()
                return
            }
            self?.lczService.add(model)
            self?.dismiss(animated: true)
        }
    }
    
    func setLocationTextFields() {
        guard let latitude = currentCoordinates?.latitude else { return }
        guard let longitude = currentCoordinates?.longitude else { return }
        
        latitudeTextField.text = String(latitude)
        longitudeTextField.text = String(longitude)
    }
    
    func getLCZModel(completion: @escaping (LCZModel?) -> Void) {
        let lczType = LCZType.allCases[lczPickerView.selectedRow(inComponent: 0)]
        guard images.count == 4 else {
            completion(nil)
            return
        }
        guard let coordinates = getCoordinates() else {
            completion(nil)
            return
        }
        getCityState(for: coordinates) { cityState in
            guard let cityState = cityState else {
                completion(nil)
                return
            }
            
            let model = LCZModel(lczType: lczType,
                            location: coordinates,
                            cityState: cityState,
                            dateTime: Date(),
                            images: [])
            completion(model)
        }
        
        
    }
    
    func getCoordinates() -> CLLocationCoordinate2D? {
        guard let latitudeString = latitudeTextField.text else { return nil }
        guard let longitudeString = longitudeTextField.text else { return nil }
               
        guard let latitude = Double(latitudeString) else { return nil }
        guard let longitude = Double(longitudeString) else { return nil }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func getCityState(for coordinates: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first,
                let state = placemark.administrativeArea,
                let city = placemark.locality else {
                completion(nil)
                return
            }
            
            let cityState = "\(city), \(state)"
            
            completion(cityState)
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Oops!",
                                      message: "Some information is missing. Make sure all fields are entered.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count == 4 ? images.count : images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == images.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyPhotoCollectionViewCell", for: indexPath) as! EmptyPhotoCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyPhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
            cell.bind(data: images[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > images.count - 1 {
            let vc = UIImagePickerController()
            vc.delegate = self
            
            let actionSheet = UIAlertController(title: "Select photo source", message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                vc.sourceType = .camera
                self.present(vc, animated: true)
            }
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { _ in
                vc.sourceType = .photoLibrary
                self.present(vc, animated: true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(cameraAction)
            actionSheet.addAction(photoLibraryAction)
            actionSheet.addAction(cancelAction)
            
            present(actionSheet, animated: true)
        }
    }
    
}

extension AddViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentCoordinates = location.coordinate
        locationManager.stopUpdatingLocation()
        setLocationTextFields()
    }
}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lczPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lczPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont(name: "JetBrainsMono-Regular", size: 16)!]
        
        var pickerLabel: UILabel? = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.attributedText = NSAttributedString(string: lczPickerData[row], attributes: attributes)

        return pickerLabel!
    }
}

extension AddViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        images.append(image)
    }
}
