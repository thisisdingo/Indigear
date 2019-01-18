//
//  IndigearResult.swift
//  Indigear
//
//  Created by Michil on 18/01/2019.
//  Copyright © 2019 Michil. All rights reserved.
//

public struct IndigearResult {
    public var statusCode : Int? = nil
    public var isSuccess : Bool {
        return error == nil
    }
    
    public var result : Data? = nil
    public var error : Error? = nil
    
    
    
}
