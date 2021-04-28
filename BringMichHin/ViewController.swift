//
//  ViewController.swift
//  BringMichHin
//
//  Created by Andreas Wassmer on 26.04.21.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var rootView: UIView!
    @IBOutlet weak var currentLocation: UITextField!
    @IBOutlet weak var bearingField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.backgroundColor = .orange
        return mapView
    }()

    var bearingView: BearingViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //rootView.addSubview(controlView)
        bearingView = BearingViewController()
        bearingView.mapView = mapView
        bearingView.checkLocationServices()
        mapView.delegate = bearingView
        rootView.addSubview(mapView)

        if let loc = bearingView.readCurrentPosition() {
            currentLocation.text = String(format:"%.5f, %.5f", loc.latitude, loc.longitude)
        } else {
            currentLocation.text = "Kein GPS Signal"
        }
        addConstraints()
    }

    @IBAction func doBearingBtnPressed(_ sender: Any) {
        guard let bearing = Double(bearingField.text!) else { return }
        guard let distance = Double(distanceField.text!) else { return }
        
        if let currLocation = bearingView.readCurrentPosition() {
            let loc = Bearing.coordinatesFromBearing(location: currLocation, bearing: bearing, distance: distance)
            bearingView.setMarkerOnBearingPoint(location: loc)
        }else {
            return
        }
    }

    @IBAction func updateLocationBtnPressed(_ sender: Any) {
        if let loc = bearingView.readCurrentPosition() {
            currentLocation.text = String(format:"%.5f, %.5f", loc.latitude, loc.longitude)
            bearingView.centerViewOnUserLocation()
        } else {
            currentLocation.text = "Kein GPS Signal"
        }
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(mapView.widthAnchor.constraint(equalTo: rootView.widthAnchor))
        constraints.append(mapView.heightAnchor.constraint(equalTo: rootView.heightAnchor, multiplier: 0.55))
        constraints.append(mapView.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor))

        NSLayoutConstraint.activate(constraints)
    }

    
}

