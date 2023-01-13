//
//  MyAddress.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 24/12/22.
//

import UIKit
import MapKit
import CoreLocation

class MyAddress: UIViewController {
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let regionInMeters: Double = 10000
    private var previousLocation: CLLocation?
    
     
    private let labelImageView: UIImageView = {
        let imageView = UIImageView()
        var image = UIImage(systemName: "mappin.and.ellipse")
        image = image?.withRenderingMode(.alwaysOriginal)
        imageView.image = image
        return imageView
    }()
    
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "He"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    
    private lazy var goToBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.setTitle("back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        checkLocationServices()
        setupLayout()
    }
    
    
    // Setup our Methods
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    private func checkLocationServices() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.checkLocationAuthorization()
                self.setupLocationManager()
            } else {
                 
            }
        }
    }
    
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }
    
    
    private func startTrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longtitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longtitude)
    }
    
    
    @objc private func backButtonDidTap() {
        dismiss(animated: true)
    }
    
    
    // Setup our UI to the Screen
    private func setupLayout() {
        view.addSubview(mapView)
        mapView.addSubview(goToBackButton)
        mapView.addSubview(labelImageView)
        view.addSubview(addressLabel)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        goToBackButton.translatesAutoresizingMaskIntoConstraints = false
        labelImageView.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: addressLabel.topAnchor),
            
            goToBackButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 15),
            goToBackButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -15),
            goToBackButton.widthAnchor.constraint(equalToConstant: 80),
            goToBackButton.heightAnchor.constraint(equalToConstant: 40),
            
            labelImageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            labelImageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -20),
            labelImageView.widthAnchor.constraint(equalToConstant: 40),
            labelImageView.heightAnchor.constraint(equalToConstant: 40),
            
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addressLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
}







extension MyAddress: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = previousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] placemark, error in
            guard let self = self else { return }
            
            if let _ = error {
                // TODO
                return
            }
            
            guard let placemark = placemark?.first else {
                // TODO
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetName) \(streetNumber)"
            }
            
        }
    }
    
}


extension MyAddress: CLLocationManagerDelegate {
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
//    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
