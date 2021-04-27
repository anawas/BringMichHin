//
//  BringMichHinTests.swift
//  BringMichHinTests
//
//  Created by Andreas Wassmer on 26.04.21.
//

import XCTest
import Foundation
import CoreLocation

@testable import BringMichHin

class BringMichHinTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let start = CLLocationCoordinate2D(latitude: 47.33087361566646, longitude: 9.41103087397927)
        let coords = Bearing.coordinatesFromBearing(location: start, bearing: 204, distance: 285)
        
        NSLog("%.6f, %.6f", coords.latitude, coords.longitude)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
