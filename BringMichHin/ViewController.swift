//
//  ViewController.swift
//  BringMichHin
//
//  Created by Andreas Wassmer on 26.04.21.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentLocation: UITextField!
    var bearingView: BearingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bearingView = BearingView()
        bearingView.mapView = mapView
        bearingView.checkLocationServices()
        mapView.delegate = bearingView
        if let loc = bearingView.readCurrentPosition() {
            currentLocation.text = String(format:"%.5f, %.5f", loc.latitude, loc.longitude)
        } else {
            currentLocation.text = "Kein GPS Signal"
        }
    }

    @IBAction func doBearingBtnPressed(_ sender: Any) {
        let loc = CLLocationCoordinate2D(latitude:47.33156332118081, longitude:8.295973279465715)
        bearingView.setMarkerOnBearingPoint(location: loc)
    }

    @IBAction func updateLocationBtnPressed(_ sender: Any) {
        if let loc = bearingView.readCurrentPosition() {
            currentLocation.text = String(format:"%.5f, %.5f", loc.latitude, loc.longitude)
            bearingView.centerViewOnUserLocation()
        } else {
            currentLocation.text = "Kein GPS Signal"
        }
    }
    
}

