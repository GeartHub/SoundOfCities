//
//  SoundOfCitiesTests.swift
//  SoundOfCitiesTests
//
//  Created by Geart Otten on 08/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import XCTest
@testable import SoundOfCities

class SoundOfCitiesTests: XCTestCase {
    var testPackage = Package()
    var realPackage = Package()
    var zoneManager = ZoneManager.instance
    
    override func setUp() {
        testPackage.makeTestPackage(type: .testData)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testZones(){
        XCTAssertTrue(zoneManager.zones.count == 4)
        XCTAssertTrue(zoneManager.hotspots.count == 2)
        XCTAssertTrue(zoneManager.zones[1].zoneName == "b088f1d9e4dc319bdc1986b141a16d03.mp3")
        XCTAssertTrue(zoneManager.zones[3].radius == Double("565.980325690556"))
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
