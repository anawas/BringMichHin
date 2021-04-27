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

    @IBAction func updateLocationBtnPressed(_ sender: Any) {
        if let loc = bearingView.readCurrentPosition() {
            currentLocation.text = String(format:"%.5f, %.5f", loc.latitude, loc.longitude)
        } else {
            currentLocation.text = "Kein GPS Signal"
        }
    }
    
}

