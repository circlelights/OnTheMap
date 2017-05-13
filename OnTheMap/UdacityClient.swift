//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Developer2017 on 5/3/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation

class UdacityClient : NSObject {
    
    
    // shared session
    var session = URLSession.shared
    
    func taskForPOSTMethod(_ method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
 
    /*
     Steps for Authentication...
     https://www.udacity.com/api/session
     
     Step 1: Create a request token
     Step 2: Ask the user for permission via the API ("login")
     Step 3: Create a session ID
     
     
     Extra Steps...
     Step 4: Get the user id ;)
     Step 5: Go to the next view!
     */
    let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.httpBody = "{\"udacity\": {\"username\": \"\(emailTextField.text!)\", \"password\": \"\(passwordTextField.text!)\"}}".data(using: String.Encoding.utf8)
        
    //let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        print("\nLoginViewController.loginPressed.task closure...")
        if error != nil { // Handle error…
            //                   self.displayError(<#T##errorString: String?##String?#>)
            return
        }
        
        let range = Range(5..<data!.count)
        let newData = data?.subdata(in: range) /* subset response data! */
        print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
        print("\tfinished printing data...")
        
        
    }
    task.resume()
        return task
}


    
    
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
