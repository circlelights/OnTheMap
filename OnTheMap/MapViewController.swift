//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Jason Isler on 5/16/17.
//  Copyright © 2017 Developer2017. All rights reserved.

import UIKit
import MapKit

/**
 * This view controller demonstrates the objects involved in displaying pins on a map.
 *
 * The map is a MKMapView.
 * The pins are represented by MKPointAnnotation instances.
 *
 * The view controller conforms to the MKMapViewDelegate so that it can receive a method
 * invocation when a pin annotation is tapped. It accomplishes this using two delegate
 * methods: one to put a small "info" button on the right side of each pin, and one to
 * respond when the "info" button is tapped.
 */

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // The map. See the setup in the Storyboard file. Note particularly that the view controller
    // is set up as the map view's delegate.
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The "locations" array is an array of dictionary objects that are similar to the JSON
        // data that you can download from parse.
        let locations = hardCodedLocationData()
        
        // We will create an MKPointAnnotation for each dictionary in "locations". The
        // point annotations will be stored in this array, and then provided to the map view.
        var annotations = [MKPointAnnotation]()
        
        // The "locations" array is loaded with the sample data below. We are using the dictionaries
        // to create map annotations. This would be more stylish if the dictionaries were being
        // used to create custom structs. Perhaps StudentLocation structs.
        
        for dictionary in locations {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(dictionary["latitude"] as! Double)
            let long = CLLocationDegrees(dictionary["longitude"] as! Double)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary["firstName"] as! String
            let last = dictionary["lastName"] as! String
            let mediaURL = dictionary["mediaURL"] as! String
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
        
    }
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
    //    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    //
    //        if control == annotationView.rightCalloutAccessoryView {
    //            let app = UIApplication.sharedApplication()
    //            app.openURL(NSURL(string: annotationView.annotation.subtitle))
    //        }
    //    }
    
    // MARK: - Sample Data
    
    // Some sample data. This is a dictionary that is more or less similar to the
    // JSON data that you will download from Parse.
    
    func hardCodedLocationData() -> [[String : AnyObject]] {
        return  [
            [
                "createdAt" : "2015-02-24T22:27:14.456Z" as AnyObject,
                "firstName" : "Jessica" as AnyObject,
                "lastName" : "Uelmen" as AnyObject,
                "latitude" : 28.1461248 as AnyObject,
                "longitude" : -82.75676799999999 as AnyObject,
                "mapString" : "Tarpon Springs, FL" as AnyObject,
                "mediaURL" : "www.linkedin.com/in/jessicauelmen/en" as AnyObject,
                "objectId" : "kj18GEaWD8" as AnyObject,
                "uniqueKey" : 872458750 as AnyObject,
                "updatedAt" : "2015-03-09T22:07:09.593Z" as AnyObject
            ], [
                "createdAt" : "2015-02-24T22:35:30.639Z" as AnyObject,
                "firstName" : "Gabrielle" as AnyObject,
                "lastName" : "Miller-Messner" as AnyObject,
                "latitude" : 35.1740471 as AnyObject,
                "longitude" : -79.3922539 as AnyObject,
                "mapString" : "Southern Pines, NC" as AnyObject,
                "mediaURL" : "http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en" as AnyObject,
                "objectId" : "8ZEuHF5uX8" as AnyObject,
                "uniqueKey" : 2256298598 as AnyObject,
                "updatedAt" : "2015-03-11T03:23:49.582Z" as AnyObject
            ]        ]
    }
}

