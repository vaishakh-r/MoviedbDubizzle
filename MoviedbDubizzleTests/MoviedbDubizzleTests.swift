//
//  MoviedbDubizzleTests.swift
//  MoviedbDubizzleTests
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import XCTest
@testable import MoviedbDubizzle


class MoviedbDubizzleTests: XCTestCase {
    var utils: CommonUtils!
    
    override func setUp() {
        super.setUp()
        utils = CommonUtils()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        utils = nil
        super.tearDown()
    }
    
    func testUtilFunctionality() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let dateString = utils.getYearFromDateString(dateString: "2017-04-12")
      XCTAssertEqual(dateString, "2017")
     
      let urlString = utils.getImageUrl(posterPath: "/hello.png", imageType: .W500)
      let testString = "\(GlobalConstants.imageBaseUrl)/w500/hello.png"
      XCTAssertEqual(urlString, testString)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
