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
        

        Indigear.post("ajsdhk://sdafdsaf") { [weak self] result in
            
            if result.isSuccess {
                print(result.result!)
            }else{
                print(result.error!.localizedDescription)
            }
            
        }
        
    }


}

