//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Developer2017 on 5/3/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation

class UdacityClient : NSObject {
    
    func taskForPOST (request:NSMutableURLRequest, completionHandlerForPOST:@escaping (_ data:Data?, _ error: String?)->Void) {
        // MARK: TODO - implement the network request based on the Udacity documentation
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            print("\nLoginViewController.loginPressed.task closure...")
            if error != nil { // Handle error…
                //                   self.displayError(<#T##errorString: String?##String?#>)
                return
            }
            
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            //self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
            convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
    }
    
    // given raw JSON, return a usable Foundation object
    func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
        
        
    
    // shared session
    //    var session = URLSession.shared
    var studentInfo = LoginViewController()
 
    
    
    //MARK: TODO Define properties for storing student ID, First Name, & Last NAme
    
    //func taskForPOSTMethod01(_ method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
    func taskForPOSTMethod01(_ method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
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
    request.httpBody = "{\"udacity\": {\"username\": \"\(studentInfo.emailTextField.text!)\", \"password\": \"\(studentInfo.passwordTextField.text!)\"}}".data(using: String.Encoding.utf8)
        
    let session = URLSession.shared
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
    
    func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
