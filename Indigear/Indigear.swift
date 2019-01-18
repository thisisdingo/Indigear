//
//  Indigear.swift
//  Indigear
//
//  Created by Michil on 13/01/2019.
//  Copyright © 2019 Michil. All rights reserved.
//

import Foundation

struct Threads {
    static let mainThread = DispatchQueue.main
    static let backgroundThread = DispatchQueue.global(qos: .background)
}

public typealias IndigearHeader = [String : String]

fileprivate let instance = Indigear()

public class Indigear {
    
    class var sharedInstance : Indigear {
        return instance
    }
    
    private func request(_ url : URL, method : HTTPMethod, _ headers : IndigearHeader?, _ body : Data?, _ completion : @escaping(_ result : IndigearResult) -> Void){
        
        let session = URLSession(configuration: .default)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            var result = IndigearResult()
            result.error = error
            result.result = data

            
            if let httpResponse = response as? HTTPURLResponse {
                result.statusCode = httpResponse.statusCode
            }
            
            Threads.mainThread.async {
                completion(result)
            }
        }
        
        Threads.backgroundThread.async {
            task.resume()
        }
    }
    
    
    // MARK : Public methods

    public static func post(_ url : String, _ headers : IndigearHeader? = nil, _ body : Any? = nil, _ completion : @escaping(_ result : IndigearResult) -> Void) {
        
        guard let fullUrl = URL(string: url) else {
            var result = IndigearResult()
            result.error = IndigearError("URL: \(url) have invalid format")
            completion(result)
            return
        }
        
        var postBody : Data? = nil
        
        if let parameters = body as? [String : String] {
            
            var postBodyQuery = String()
            
            for key in parameters.keys {
                if postBodyQuery.isEmpty {
                    postBodyQuery = "\(key)=\(parameters[key]!)"
                } else {
                    postBodyQuery += "&\(key)=\(parameters[key]!)"
                }
            }
            
            postBody = postBodyQuery.data(using: .utf8)
        } else if let data = body as? Data {
            postBody = data
        } else if let data = body as? String {
            postBody = data.data(using: .utf8)
        }
        
        Indigear.sharedInstance.request(fullUrl, method: .post, headers, postBody, completion)
    }
    
    public static func get(_ url : String, _ headers : IndigearHeader? = nil, _ body : Any? = nil, _ completion : @escaping(_ result : IndigearResult) -> Void) {
        
        guard let fullUrl = URL(string: url) else {
            var result = IndigearResult()
            result.error = IndigearError("URL: \(url) have invalid format")
            completion(result)
            return
        }
        
        var getBody : Data? = nil
        
        if let parameters = body as? [String : String] {
            
            var bodyQuery = String()
            
            for key in parameters.keys {
                if bodyQuery.isEmpty {
                    bodyQuery = "\(key)=\(parameters[key]!)"
                } else {
                    bodyQuery += "&\(key)=\(parameters[key]!)"
                }
            }
            
            getBody = bodyQuery.data(using: .utf8)
        }
        
        Indigear.sharedInstance.request(fullUrl, method: .get, headers, getBody, completion)
    }
    
}

class IndigearError : Error {
    
    var description = String()
    
    init(_ withDescription : String) {
        self.description = withDescription
    }
    
    
    var localizedDescription: String {
        return description
    }
    
}
