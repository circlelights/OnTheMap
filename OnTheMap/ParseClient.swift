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
    
    
    
    
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
}
