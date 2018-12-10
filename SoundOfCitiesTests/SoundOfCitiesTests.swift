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
    var package = Package()
    
    override func setUp() {
        package.makeTestPackage()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testZones(){
        XCTAssertEqual(package.zones.count, 5)
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
