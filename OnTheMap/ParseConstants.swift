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
        
        // MARK: API Key and Application ID
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        // MARK: URLs
        static let ParseURL = "https://parse.udacity.com/parse/classes/StudentLocation"
        static let Where = "https://parse.udacity.com/parse/classes/StudentLocation?where="

        
    }
    // MARK: Parameter Keys
    struct ParseParameterKeys {
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        static let Email = "email"
        static let Password = "password"
    }
    
    // MARK: Parse Response Keys
    struct ParseResponseKeys {
        static let Status = "status"
        static let Registered = "registered"
        static let Key = "key"
        static let Session = "session"
        static let ID = "id"
        static let Expiration = "expiration"
    }
    
}
