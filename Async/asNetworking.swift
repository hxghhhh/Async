//
//  asNetworking.swift
//  Async
//
//  Created by Regynald Augustin on 9/26/15.
//  Copyright © 2015 HAM. All rights reserved.
//

import Foundation

class asNetworking {
    class func get(url: String, parameters: [String: AnyObject], completion: (String?, String?) -> Void) {
        var parameterString = "?"
        for (key, value) in parameters {
            parameterString += "\(key)=\(value)&"
        }
        parameterString = parameterString.substringToIndex(parameterString.endIndex.predecessor())
        let requestURL = NSURL(string:"\(url)\(parameterString)")!
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                completion(nil, error?.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding) as? String
                completion(result, nil)
            }
        }
        task.resume()
    }
    
    class func post(url: String, parameters: [String: AnyObject], completion: (String?, String?) -> Void) {
        let requestURL = NSURL(string:url)!
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "POST"
        do {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.PrettyPrinted)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
                if error != nil {
                    completion(nil, error?.localizedDescription)
                } else {
                    let result = NSString(data: data!, encoding: NSUTF8StringEncoding) as? String
                    completion(result, nil)
                }
            }
            task.resume()
        } catch _ {
            completion(nil, "Couldn't parse paramteres")
        }
    }
}