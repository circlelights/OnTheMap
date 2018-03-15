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
   // (_ success: Bool, _ error:String?)
    func authenticateUser (email:String, password:String, completionHandler: @escaping (_ success:Bool, _ errorString: String) -> Void) {

        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        

            // MARK: TODO - get parsedResult from data -  call  taskForPost method in UdacityClient.swift  - for authenticating user
            //taskForPOST(request: request) { (data, error) in
            if error != nil { // Handle error…
                    completionHandler(false, "Is your Internet operating correctly?")
                
            } else {
                let range = Range(5..<data!.count)
                if let newData = data?.subdata(in: range) {
                    do {
                        let newUserInfo = try JSONSerialization.jsonObject(with: newData, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
                        print(newUserInfo)
                        
                        if let theStatus = newUserInfo["status"]{
                            print(newUserInfo["error"])
                        completionHandler(false,newUserInfo["error"] as! String)
                        } else {
                            // MARK: TODO - extract Udacity user ID and save it in StudentInfo struct
                            let thisAccount = newUserInfo["account"] as! [String:AnyObject]
                            let thisSession = newUserInfo["session"] as! [String:AnyObject]
                            
                                if let key = thisAccount["key"] as? String {
                                    UdacityClient.StudentInfo.studentID = key
                                }
                                else {
                                    // MARK: TODO - take care of this fail point
                                    completionHandler(false, "Account is Incorrect or misspelled")
                                }

                            // MARK: TODO - extract Udacity session ID and save it in StudentInfo struct
                
                                if let id = thisSession["id"] as? String  {
                                    UdacityClient.StudentInfo.sessionID = id
                                    completionHandler(true,"")
                                }
                
                            }
                
                    } catch{}
                }else {
                            completionHandler(false, "Unknown Error; Try Again")
                        }
                    }
                }
                
                task.resume()
            }
}
