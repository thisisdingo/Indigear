//
//  IndigearTests.swift
//  IndigearTests
//
//  Created by Michil on 13/01/2019.
//  Copyright © 2019 Michil. All rights reserved.
//

import Foundation
import XCTest
@testable import Indigear

class IndigearTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIndigear(){
        
        let e = expectation(description: "Indigear")
        
        let params = ["param1" : "value1"]
        
        let requestURL = "http://indigear.michil.ru"
        
        Indigear.run(requestURL, method: .post, body: params) { result in
            if result.isSuccess {
                do {
                    let result = try JSONSerialization.jsonObject(with: result.result!, options: []) as! [String : Any]
                    
                    XCTAssertNotNil(result, "No response")
                    
                    var postRequests = [String : String]()
                    postRequests = result["POST"] as! [String : String]
                    
                    if (postRequests == params) {
                        e.fulfill()
                    }else{
                        XCTFail("Requests not equals to responce")
                    }

                } catch {
                    XCTAssertNil(error, "Error: \(error.localizedDescription)")
                }
                
            }else{
                XCTAssertNil(result.error, "Request error: \(result.error!.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)

        
    }

}
