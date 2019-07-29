//
//  IndigearError.swift
//  Indigear
//
//  Created by Mister Gamburger on 29/07/2019.
//  Copyright © 2019 Michil. All rights reserved.
//

import Foundation

class IndigearError : NSError {
    
    var errorDescription = String()
    
    init(_ withDescription : String) {
        super.init(domain: "IndigearError", code: 0, userInfo: nil)
        self.errorDescription = withDescription
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var localizedDescription: String {
        return errorDescription
    }
    
}
