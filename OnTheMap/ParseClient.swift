//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Jason Isler on 5/13/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation

class ParseClient : NSObject {
    
    // shared session
    var session = URLSession.shared
    //Parse GET Student Locations Method  URL May need parameters added
    func taskForGETParse (request:NSMutableURLRequest, completionHandlerForGET:@escaping (_ data:AnyObject?, _ error: NSError?)->Void) {
        
        let request = NSMutableURLRequest(url: URL(string: ParseConstants.ParseGET)!)
        request.addValue(ParseConstants.ApiKey, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseConstants.ApplicationID, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard data == nil else {
                print("No data was returned by the request!")
                return
            }
            self.convertDataWithCompletionHandler(data!, completionHandlerForConvertData: completionHandlerForGET)

        }
        task.resume()
    }
    //Parse GET single Student Location Method - URL needs WHERE parameter added
    func taskForGETSingleLocationParse (request:NSMutableURLRequest, completionHandlerForGET:@escaping (_ data:AnyObject?, _ error: NSError?)->Void) {
        //Add key to urlString
        let urlString = ParseConstants.Where
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.addValue(ParseConstants.ApiKey, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseConstants.ApplicationID, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }

            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard data != nil else {
                print("No data was returned by the request!")
                return
            }
        self.convertDataWithCompletionHandler(data!, completionHandlerForConvertData: completionHandlerForGET)

    }
    task.resume()
    }
    //Task for POSTING A STUDENT LOCATION - NEED STRUCT WITH STUDENT LOCATION VARIABLES
    func taskForPOSTStudentLocationParse (request:NSMutableURLRequest, completionHandlerForPOST:@escaping (_ data:AnyObject?, _ error: NSError?)->Void) {
    
        // MARK: instance var  userStudentLocation is globally accessible from StudentLocation.swift
    
        let request = NSMutableURLRequest(url: URL(string: ParseConstants.ParsePOST)!)
        request.httpMethod = "POST"
        request.addValue(ParseConstants.ApiKey, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseConstants.ApplicationID, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(userStudentLocation.uniqueKey)\", \"firstName\": \"\(userStudentLocation.firstName)\", \"lastName\":  \"\(userStudentLocation.lastName)\",\"mapString\":  \"\(userStudentLocation.mapString)\", \"mediaURL\":  \"\(userStudentLocation.mediaURL)\",\"latitude\":  \"\(userStudentLocation.latitude)\", \"longitude\":  \"\(userStudentLocation.longitude)\"}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
                /* GUARD: Was there an error? */
                guard (error == nil) else {
                    print("There was an error with your request: \(error!)")
                    return
                }
                
                /* GUARD: Did we get a successful 2XX response? */
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                    print("Your request returned a status code other than 2xx!")
                    return
                }
                
                /* GUARD: Was there any data returned? */
                guard data != nil else {
                    print("No data was returned by the request!")
                    return
                }
//            if error != nil { // Handle error…
//                return
//            }
//            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            
            self.convertDataWithCompletionHandler(data!, completionHandlerForConvertData: completionHandlerForPOST)
        }
        task.resume()
    }
      //Task For PUT a student location - Add Object ID to the request - PUT In Convenience
       func taskForPUTStudentLocationParse (request:NSMutableURLRequest, completionHandlerForPOST:@escaping (_ data:AnyObject?, _ error: NSError?)->Void) {
            let urlString = ParseConstants.ParsePUT
            let url = URL(string: urlString)
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "PUT"
            request.addValue(ParseConstants.ApiKey, forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue(ParseConstants.ApplicationID, forHTTPHeaderField: "X-Parse-REST-API-Key")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = "{\"uniqueKey\": \"\(userStudentLocation.uniqueKey)\", \"firstName\": \"\(userStudentLocation.firstName)\", \"lastName\":  \"\(userStudentLocation.lastName)\",\"mapString\":  \"\(userStudentLocation.mapString)\", \"mediaURL\":  \"\(userStudentLocation.mediaURL)\",\"latitude\":  \"\(userStudentLocation.latitude)\", \"longitude\":  \"\(userStudentLocation.longitude)\"}".data(using: String.Encoding.utf8)
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
    }
    
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        //Instead of returning AnyObject, return StudentLocation data - get the Array of StudentLocations from JSON results
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil) 
    }
    

    
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
}
