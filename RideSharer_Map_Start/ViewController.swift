//
//  ViewController.swift
//  RideSharer_Map_Start
//
//  Created by HariprasadPulipati on 22/08/23.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
   
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        checkLocationServices()
        locationManager.requestWhenInUseAuthorization()
//        locationManager.delegate = self
//
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//        locationManager.startUpdatingLocation()
//        mapView.showsUserLocation = true
    
    }
    func setupMapView() {
            view.addSubview(mapView)
            mapView.translatesAutoresizingMaskIntoConstraints = false
            mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
            mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000)
            mapView.setRegion(region, animated: true)
        }
       
        func checkLocationAuthorization() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                followUserLocation()
                locationManager.startUpdatingLocation()
                break
            case .denied:
        
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
            
                break
            case .authorizedAlways:
                break
          
           
            }
        }
        
        func checkLocationServices() {
            if CLLocationManager.locationServicesEnabled() {
                setupLocationManager()
                checkLocationAuthorization()
            } else {
              
            }
        }
        
        func followUserLocation() {
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 4000, longitudinalMeters: 4000)
                mapView.setRegion(region, animated: true)
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
        
        func setupLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    


}

