//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Jason Isler on 10/10/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation
extension ParseClient {
    
    // MARK: Constants
    struct ParseConstants {
        
        // MARK: API Key
        static let ApiKey = "YOUR_API_KEY_HERE"
        
        // MARK: URLs
        static let ParseURL = "https://parse.udacity.com/parse/classes/StudentLocation"
        
    }
    // MARK: Parameter Keys
    struct ParseParameterKeys {
        static let ApiKey = "api_key"
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        static let Email = "email"
        static let Password = "password"
    }
    
    // MARK: Flickr Response Keys
    struct ParseResponseKeys {
        static let Status = "status"
        static let Registered = "registered"
        static let Key = "key"
        static let Session = "session"
        static let ID = "id"
        static let Expiration = "expiration"
    }
    
}
