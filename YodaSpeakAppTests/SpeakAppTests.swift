//
//  SpeakAppTests.swift
//  SpeakAppTests
//

import XCTest
@testable import SpeakApp

class SpeakAppTests: XCTestCase {
    var testString:YodaSpeak?
    let expectedString = "Learn how to speak like me someday, you will."

    override func setUp() {
        super.setUp()
        testString = YodaSpeak.init(string: "You will learn how to speak like me someday.", mashapleKey: "A2DfMRZffOmshNXzz8C68DVCjolLp1hGBp3jsnoIraMcpk68Nn")
    }
    
    override func tearDown() {
        testString = nil
        super.tearDown()
    }
    
    func testYodaSpeak() {
        let asyncExpectation = expectation(description: "Wait for Yoda speak.")
        testString?.yoda(completionHandler: { (yodaSpoke:String?) in
            //We use contains function because yoda speak api can return more text after main one.
            //example of different answer: "Learn how to speak like me someday, you will.  Yeesssssss."
            XCTAssert((yodaSpoke?.contains(self.expectedString))!)
            asyncExpectation.fulfill()
        })

        waitForExpectations(timeout: 15.0) { (error) in
            if error != nil {
                XCTFail((error?.localizedDescription)!)
            }
        }
    }
}
