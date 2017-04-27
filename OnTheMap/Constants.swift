//
//  Constants.swift
//  OnTheMap
//
//  Created by Developer2017 on 4/27/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import UIKit

// MARK: - Constants

struct Constants {
    
    // MARK: TMDB
    struct TMDB {
        static let ApiScheme = "https"
        static let ApiHost = "udacity.com/"
        static let ApiPath = "api/session"
    }
    
    // MARK: TMDB Parameter Keys
    struct TMDBParameterKeys {
        static let ApiKey = "api_key"
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        static let Email = "email"
        static let Password = "password"
    }
    
    // MARK: TMDB Parameter Values
    struct TMDBParameterValues {
        static let ApiKey = "YOUR_API_KEY_HERE"
    }
    
    // MARK: TMDB Response Keys
    struct TMDBResponseKeys {
        static let StatusCode = "status_code"
        static let StatusMessage = "status_message"
        static let SessionID = "session_id"
        static let RequestToken = "request_token"
        static let Success = "success"
        static let UserID = "id"
        static let Results = "results"
}
}

