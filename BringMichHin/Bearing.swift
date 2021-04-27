//
//  Bearing.swift
//  Calculates the end point for the given bearing 
//  BringMichHin
//
//  Created by Andreas Wassmer on 27.04.21.
//

import CoreLocation

struct Bearing {

    static let R_Earth: Double = 6378100.0
    
    static func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180.0
    }

    static func rad2deg(_ number: Double) -> Double {
        return number * 180.0 / .pi
    }

    static func coordinatesFromBearing(location: CLLocationCoordinate2D,  bearing: Double, distance: Double) -> CLLocationCoordinate2D {
        let lat = location.latitude
        let lon = location.longitude
        
        let lat_start = deg2rad(lat)
        //let lon_start = deg2rad(lon)
        let dOverR = distance / R_Earth

        
        var lat_ziel = sin(lat_start) * cos(dOverR) + cos(lat_start) * sin(dOverR) * cos(deg2rad(bearing))
        
        
        var lon_ziel = atan2(sin(deg2rad(bearing)) * sin(dOverR) * cos(lat_start),
                        cos(dOverR)-sin(lat_start)*sin(lat_ziel))
        
        lat_ziel = rad2deg(asin(lat_ziel))
        lon_ziel = lon + rad2deg(lon_ziel)

        let coord = CLLocationCoordinate2D(latitude: lat_ziel, longitude: lon_ziel)
        return coord
    }
}
