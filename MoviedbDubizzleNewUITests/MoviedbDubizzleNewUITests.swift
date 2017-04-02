

//
//  MoviedbDubizzleNewUITests.swift
//  MoviedbDubizzleNewUITests
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import XCTest

class MoviedbDubizzleNewUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInfiniteScrolling() {
        
       let collectionView = app.collectionViews.element(boundBy: 0)
       let lastCell = collectionView.cells.element(boundBy: collectionView.cells.count)
       collectionView.scrollToElement(element: lastCell)
 
    }
    
    func testPopup() {
        
        app.buttons["filter"].tap()
        app.textFields["fromTextLabel"].tap()
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "2013")
        XCTAssertEqual(app.textFields["fromTextLabel"].value as! String, "2013")
        app.textFields["toTextLabel"].tap()
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "2015")
        XCTAssertEqual(app.textFields["toTextLabel"].value as! String, "2015")
        app.switches["1"].tap()
        app.buttons["closeButton"].tap()
        XCTAssert(app.staticTexts["2013"].exists)
        XCTAssert(app.staticTexts["2015"].exists)
        XCTAssert(app.staticTexts["Oldest"].exists)
        
    }
    
}
