//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Developer2017 on 4/7/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10.0
    }
    
    
//    let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
//    request.httpMethod = "POST"
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: String.Encoding.utf8)
//    let session = URLSession.shared
//    let task = session.dataTask(with: request as URLRequest) { data, response, error in
//        if error != nil { // Handle error…
//            return
//        }
//        let range = Range(5..<data!.count)
//        let newData = data?.subdata(in: range) /* subset response data! */
//        print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
//    }
//    task.resume()
    

    
}
