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
        

            // MARK: TODO - get parsedResult from data
            taskForPOST(request: request) { (data, error) in
                
            // MARK: TODO - extract Udacity user ID and save it in StudentInfo struct
            if let thisAccount = data?["account"] as? [String:AnyObject] {
                if let key = thisAccount["key"] as? String {
                    UdacityClient.StudentInfo.studentID = key
                }
                else {
                    // MARK: TODO - take care of this fail point
                    completionHandler(false, "Account is Incorrect or misspelled")
                }
            }
            else {
                // MARK: TODO - take care of this fail point
                completionHandler(false, "The Key is incorrect")
            }
            // MARK: TODO - extract Udacity session ID and save it in StudentInfo struct
            
            if let thisSession = data?["session"] as? [String:AnyObject] {
                if let id = thisSession["id"] as? String  {
                    UdacityClient.StudentInfo.sessionID = id
                    //completion handler with session id and nil error

                } else {
                    print("Invalid Session ID (nil)")
                    
                }
                
            }
            else {
                /// MARK: TODO - take care of this fail point
            }
            guard error == nil else {
                completionHandler(false, "\(String(describing: error))") //  to convert NSError to string
                return
            }
            
            // success means: - I have etracted the user ID and stored it in UdacityClient
            completionHandler(true, nil)
        }
    }
    
}


    
