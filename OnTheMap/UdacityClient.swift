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
            print(parsedResult)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            print(userInfo)
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }

    
    //MARK: TODO Define properties for storing student ID, First Name, & Last Name
    struct StudentInfo {
        
        static var studentID: String = ""  // this is thisAccount["key"] - from JSON returned for succesful login
        static var sessionID: String = ""  // this thisSession["id"] - from JSON returned for succesful login
        static var firstName: String = ""   // from JSON returned for successful GETting of Student's Public User Data from Udacity
        static var lastName: String = ""   // from JSON returned for successful GETting of Student's Public User Data from Udacity
    }


    
    // MARK: Shared Instance
    
    func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
