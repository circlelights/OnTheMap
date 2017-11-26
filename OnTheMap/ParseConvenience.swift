//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Jason Isler on 5/13/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation

extension ParseClient {

struct StudentLocation {
    let objectId: String?
    let uniqueKey: String
    let firstName: String
    let lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
}
    //This should be placed in Client
    func parseGETRequest() {
    let request = NSMutableURLRequest(url: URL(string: ParseConstants.ParseURL)!)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        if error != nil { // Handle error...
            return
        }
        
        print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
    }
    task.resume()
}
    
}


