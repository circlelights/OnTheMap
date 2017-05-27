//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Developer2017 on 5/3/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation

extension UdacityClient {



func authenticateWithViewController(_ hostViewController: LoginViewController, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
    
                     self.getSessionID() { (success, sessionID, errorString) in
                        
                        if success {
                            
                            // success! we have the sessionID!
                            self.sessionID = sessionID
                            
                            self.getUserID() { (success, userID, errorString) in
                                
                                if success {
                                    
                                    if let userID = userID {
                                        
                                        // and the userID 😄!
                                        self.userID = userID
                                    }
                                }
                                
                                completionHandlerForAuth(success, errorString)
                            }
                        } else {
                            completionHandlerForAuth(success, errorString)
                        }
                    }
                }
    
              }






    // MARK: GET
    
    func taskForGETMethod(_ method: String, parameters: [String:AnyObject], completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard data != nil else {
                sendError("No data was returned by the request!")
                return
            }
            
    }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }




private func getSessionID(completionHandlerForSession: @escaping (_ success: Bool, _ sessionID: String?, _ errorString: String?) -> Void) {
    
    
    /* 2. Make the request */
//    let _ = taskForGETMethod(Methods.AuthenticationSessionNew, parameters: parameters as [String:AnyObject]) { (results, error) in
    let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)

    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        print("\nLoginViewController.loginPressed.task closure...")
        if error != nil { // Handle error…
            //                   self.displayError(<#T##errorString: String?##String?#>)
            return
        }
 
        /* 3. Send the desired value(s) to completion handler */
        if let error = error {
            print(error)
            completionHandlerForSession(false, nil, "Login Failed (Session ID).")
        } else {
            if let sessionID = results?[UdacityClient.JSONResponseKeys.SessionID] as? String {
                completionHandlerForSession(true, sessionID, nil)
            } else {
                print("Could not find \(UdacityClient.JSONResponseKeys.SessionID) in \(results)")
                completionHandlerForSession(false, nil, "Login Failed (Session ID).")
            }
//        }
    }
}

private func getUserID(_ completionHandlerForUserID: @escaping (_ success: Bool, _ userID: Int?, _ errorString: String?) -> Void) {
    
    /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
    let parameters = [UdacityClient.ParameterKeys.SessionID: UdacityClient.sharedInstance().sessionID!]
    
    /* 2. Make the request */
//    let _ = taskForGETMethod(Methods.Account, parameters: parameters as [String:AnyObject]) { (results, error) in
        
        /* 3. Send the desired value(s) to completion handler */
        if let error = error {
            print(error)
            completionHandlerForUserID(false, nil, "Login Failed (User ID).")
        } else {
            if let userID = results?[UdacityClient.JSONResponseKeys.UserID] as? Int {
                completionHandlerForUserID(true, userID, nil)
            } else {
                print("Could not find \(UdacityClient.JSONResponseKeys.UserID) in \(results)")
                completionHandlerForUserID(false, nil, "Login Failed (User ID).")
            }
//        }
    }
    
}
    

    
