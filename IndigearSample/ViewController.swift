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
        
        Indigear.run(Constants.API_URL, method: .get) { result in
            if result.isSuccess {
                print("Fetched data: ", String(data: result.result!, encoding: .utf8) ?? "")
            }else{
                print("Error: ", result.error!.localizedDescription)
            }
        }
    }
}

