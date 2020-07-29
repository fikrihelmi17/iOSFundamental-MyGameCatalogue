//
//  MyGameCatalogueUITests.swift
//  MyGameCatalogueUITests
//
//  Created by Fikri on 26/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import XCTest

class MyGameCatalogueUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let staticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["97"]/*[[".cells.staticTexts[\"97\"]",".staticTexts[\"97\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        staticText.tap()
        app.buttons["Button"].tap()
        app.alerts.scrollViews.otherElements.buttons["OK"].tap()
        
        let element3 = app.otherElements.statusBars.children(matching: .other).element.children(matching: .other).element
        let element = element3.children(matching: .other).element(boundBy: 1)
        element.tap()
        
        let scrollView = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 2 pages")/*[[".windows[\"SBCoverSheetWindow\"].scrollViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\")",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .scrollView).element
        scrollView.swipeDown()
        element.tap()
        
        let scrollView2 = app.otherElements["ControlCenterView"].children(matching: .scrollView).element
        scrollView2/*@START_MENU_TOKEN@*/.press(forDuration: 0.2);/*[[".tap()",".press(forDuration: 0.2);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        scrollView2.swipeUp()
        element3.children(matching: .other).element(boundBy: 0).tap()
        scrollView.swipeDown()
        scrollView.tap()
        app.textViews.staticTexts["Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update.  Simultaneous storytelling from three unique perspectives:  Follow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from.  GTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged."].swipeUp()
        
        let detailGameNavigationBar = app.navigationBars["Detail Game"]
        detailGameNavigationBar.buttons["My Games"].tap()
        
        let tabBarsQuery = app.tabBars
        let myFavoritesButton = tabBarsQuery.buttons["My Favorites"]
        myFavoritesButton.tap()
        myFavoritesButton.tap()
        staticText.tap()
        detailGameNavigationBar.buttons["My Favorites"].tap()
        tabBarsQuery.buttons["My Profile"].tap()
        app.navigationBars["My Profile"].buttons["Edit"].tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element2.children(matching: .textField).element(boundBy: 0).tap()
        
        let textField = element2.children(matching: .textField).element(boundBy: 3)
        textField.tap()
        textField.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Image"]/*[[".buttons[\"Get Image\"].staticTexts[\"Get Image\"]",".staticTexts[\"Get Image\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
