//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Developer2017 on 5/3/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    // Convenience Method for authenticating Udacity User
    
    func authenticateUser (email:String, password:String, completionHandler: @escaping (_ success: Bool, _ error:String?) -> Void) {
        // MARK: TODO
        /*
         call  taskForPost method in UdacityClient.swift  - for authenticating user
        
         */
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        
        taskForPOST(request: request) { (data, error) in
            // MARK: TODO - get parsedResult from data
            
            // MARK: TODO - extract Udacity user ID and save it in StudentInfo struct
            
            // MARK: TODO - extract Udacity session ID and save it in StudentInfo struct
            guard error != nil else {
                completionHandler(false, "\(String(describing: error))") //  to convert NSError to string
                return
            }
            
            // success means: - I have etracted the user ID and stored it in UdacityClient
            completionHandler(true, nil)
        }
    }
}
 

    
