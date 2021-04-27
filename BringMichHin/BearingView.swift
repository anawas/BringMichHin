//
//  BearingView.swift
//  BringMichHin
//
//  Created by Andreas Wassmer on 26.04.21.
//

import UIKit
import MapKit
import CoreLocation

class BearingView: NSObject, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 500
    var mapView: MKMapView?
    
    override init(){
        super.init()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //
    //
    func readCurrentPosition() -> CLLocationCoordinate2D? {
        
        if let location = locationManager.location?.coordinate {
            return location
        }
        return nil
    }
    
    func setMarkerOnBearingPoint(location: CLLocationCoordinate2D) {
        if let markers = mapView?.annotations {
            mapView!.removeAnnotations(markers)
        }
        
        let bearingLocation = MKPointAnnotation()
        bearingLocation.coordinate = location
        mapView?.addAnnotation(bearingLocation)
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView!.setRegion(region, animated: false)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // alert user to enable location services
        }
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView!.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // show alert instructing them how to turn on permission
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break;
        case .restricted:
            // used by parental control
            // show alert instructing them how to turn on permission
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
}

extension BearingView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView!.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

