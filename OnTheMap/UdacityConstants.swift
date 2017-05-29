//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Jason Isler on 5/26/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

extension UdacityClient {
    
    // MARK: Constants
    struct Constants {
        
        // MARK: API Key
        static let ApiKey = "YOUR_API_KEY_HERE"
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api/session"

}
    // MARK: Parameter Keys
    struct UdacityParameterKeys {
        static let ApiKey = "api_key"
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        static let Email = "email"
        static let Password = "password"
    }
    
    // MARK: Flickr Response Keys
    struct UdacityResponseKeys {
        static let Status = "status"
        static let Registered = "registered"
        static let Key = "key"
        static let Session = "session"
        static let ID = "id"
        static let Expiration = "expiration"
    }

}
