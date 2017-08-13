//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Developer2017 on 5/3/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation

class UdacityClient : NSObject {
    
    func taskForPOST (request:NSMutableURLRequest, completionHandlerForPOST:@escaping (_ data:AnyObject?, _ error: NSError?)->Void) {
        // MARK: TODO - implement the network request based on the Udacity documentation
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
 
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForPOST", code: 1, userInfo: userInfo))
            }
            
            
            print("\nLoginViewController.loginPressed.task closure...")
            if error != nil { // Handle error…
                //                   self.displayError(<#T##errorString: String?##String?#>)
                
                return
            }
            
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            //self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
            self.convertDataWithCompletionHandler(newData!, completionHandlerForConvertData: completionHandlerForPOST)
        }
        task.resume()
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



   
    
    
    // MARK: Shared Instance
    
    func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
