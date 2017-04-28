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
    @IBOutlet weak var debugTextLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10.0
    }
    
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        userDidTapView(self)
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            debugTextLabel.text = "Username or Password Empty."
        } else {
            setUIEnabled(false)
            
            /*
             Steps for Authentication...
             https://www.udacity.com/api/session
             
             Step 1: Create a request token
             Step 2: Ask the user for permission via the API ("login")
             Step 3: Create a session ID
             
             Extra Steps...
             Step 4: Get the user id ;)
             Step 5: Go to the next view!
             */
             getRequestToken()
        }
    }
    
    private func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
    }
}
    
    @IBAction func userDidTapView(_ sender: AnyObject) {
        resignIfFirstResponder(emailTextField)
        resignIfFirstResponder(passwordTextField)
    }
}

private func getRequestToken() {
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
}

// MARK: - LoginViewController (Configure UI)

private extension LoginViewController {
    
    func setUIEnabled(_ enabled: Bool) {
        emailTextField.isEnabled = enabled
        passwordTextField.isEnabled = enabled
        loginButton.isEnabled = enabled
        debugTextLabel.text = ""
        debugTextLabel.isEnabled = enabled
        
        // adjust login button alpha
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }

//    let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
//    request.httpMethod = "DELETE"
//    var xsrfCookie: HTTPCookie? = nil
//    let sharedCookieStorage = HTTPCookieStorage.shared
//    for cookie in sharedCookieStorage.cookies! {
//    if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
//    }
//    if let xsrfCookie = xsrfCookie {
//        request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
//    }
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
//    
    private func escapedParameters(_ parameters: [String:AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                // make sure that it is a string value
                let stringValue = "\(value)"
                
                // escape it
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                // append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
                
            }
            
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
}

}

