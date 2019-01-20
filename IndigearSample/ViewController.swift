//
//  ViewController.swift
//  IndigearSample
//
//  Created by Michil on 18/01/2019.
//  Copyright © 2019 Michil. All rights reserved.
//

import UIKit
import Indigear

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header : IndigearHeader = ["User-Agent" : "Your Awesome Application"]
        let params = ["param1" : "value1"]
        
        let requestURL = Constants.API_URL + "?getparam1=value1&getparam=value2"
        
        Indigear.run(requestURL, method: .post, headers: header, body: params) { result in
            if result.isSuccess {
                do {
                    let result = try JSONSerialization.jsonObject(with: result.result!, options: []) as! [String : Any]
                    
                    print("Request POST parameters: ", result["POST"] ?? "")
                    print("Request GET parameters: ", result["GET"] ?? "")
                    print("Request HEADERS: ", result["HEADERS"] ?? "")
                    
                } catch {
                    print(error)
                }
                
            }else{
                print("Error: ", result.error!.localizedDescription)
            }
        }
    }
}

