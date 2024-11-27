//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Domini Valencia on 11/26/24.
//

import XCTest
import RealmSwift
@testable import TestApp

class ViewControllerTests: XCTestCase {
    
    var viewController: ViewController!
    var realm: Realm!
    
    override func setUp() {
        super.setUp()
        
        var config = Realm.Configuration()
        config.inMemoryIdentifier = self.name
        realm = try! Realm(configuration: config)
        
        viewController = ViewController()
        viewController.realm = realm
    }
    
    override func tearDown() {
        try! realm.write {
            realm.deleteAll()
        }
        
        viewController = nil
        realm = nil
        super.tearDown()
    }
    
    func testButtonPressCreatesEvent() {
        let button = viewController.button1
        let expectation = self.expectation(description: "Event should be saved to Realm")
        
        viewController.buttonPressed(button)
        
        DispatchQueue.main.async {
            let events = self.realm.objects(Event.self)
            
            // Assert that an event was created and saved
            XCTAssertEqual(events.count, 1, "Event should be saved to Realm")
            let event = events.first!
            XCTAssertEqual(event.buttonId, button.tag, "Event buttonId should match the button pressed")
            XCTAssertNotNil(event.timestamp, "Event timestamp should not be nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
