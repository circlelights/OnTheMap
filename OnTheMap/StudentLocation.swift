//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Developer2011 on 11/30/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation


struct StudentLocation {
    var objectId = String()
    var uniqueKey = String()
    var firstName = String()
    var lastName = String()
    var mapString = String()
    var mediaURL = String()
    var latitude = Double()
    var longitude = Double()
    
    init() {
        objectId = ""
        uniqueKey = ""
        firstName = ""
        lastName = ""
        mapString = ""
        mediaURL = ""
        latitude = 0.0
        longitude = 0.0
        
    }
    
    init(dictionary: [String:AnyObject]) {
        objectId  = dictionary["objectId"] as? String ?? ""
        uniqueKey = dictionary["uniqueKey"] as? String ?? ""
        firstName = dictionary["firstName"] as? String ?? ""
        lastName = dictionary["lastName"] as? String ?? ""
        mapString = dictionary["mapString"] as? String ?? ""
        mediaURL = dictionary["mediaURL"] as? String ?? ""
        latitude = dictionary["latitude"] as? Double ?? 0.0
        longitude = dictionary["longitude"] as? Double ?? 0.0
    }
}


var userStudentLocation  = StudentLocation()

