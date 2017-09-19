//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Developer2017 on 4/7/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITabBarDelegate {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet var udacityLink: UILabel!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    let udacityClient = UdacityClient().sharedInstance()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10.0
        let attrStr = try! NSAttributedString(
            data: "Don't have an account?  <a href='https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated'>Sign Up</a>".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        udacityLink.attributedText = attrStr
        
    }
    
    
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        userDidTapView(self)
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            debugTextLabel.text! = "Please enter username or password"
        } else {
            
            
            // MARK: TODO - Authenticate User by calling convenience method
            
            // authenticateUdacityUser(email, password) {() in  ...}
            
            udacityClient.authenticateUser(email: emailTextField.text!, password: passwordTextField.text!, completionHandler: { (success, error) in
                //  success  -- implies that Udacity account id has been extracted
                
                if success {
                    // MARK: TODO
                    //1 . GET from udacty, user's first_name, & last_name - store in UdacityClient
                    //2. GET from Parse - the user's student location, if it exists
                    //3. GET from Parse - the latest 100 student locations
                    //4.  Transition to the map view
                }
            })
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
            let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = "{\"udacity\": {\"username\": \"\(emailTextField.text!)\", \"password\": \"\(passwordTextField.text!)\"}}".data(using: String.Encoding.utf8)
            
            
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                print("\nLoginViewController.loginPressed.task closure...")
                if error != nil { // Handle error…
                    return
                }
                
                let range = Range(5..<data!.count)
                let newData = data?.subdata(in: range) /* subset response data! */
                var parsedResult: AnyObject! = nil
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as AnyObject
                } catch {
                    self.displayError("Could not parse the data as JSON: '\(String(describing: newData))'")
                }
                if let thisSession = parsedResult["session"] as? [String:AnyObject] {
                    if thisSession["id"] as? [String:AnyObject] != nil {
                        DispatchQueue.main.async {
                        self.completeLogin()
                        }
                    } else {
                        print("Invalid Account")
                        
                    }
                    
                }
                
                print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
                print("\tfinished printing data...")
            }
            task.resume()
            
        }
    }
    
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    
    private func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    private func completeLogin() {
        debugTextLabel.text = ""
        DispatchQueue.main.async {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "MapandTableTabView") as! UITabBarController
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func displayError(_ errorString: String?) {
        if let errorString = errorString {
            debugTextLabel.text = errorString
        }
    }
    
    
    @IBAction func userDidTapView(_ sender: AnyObject) {
        resignIfFirstResponder(emailTextField)
        resignIfFirstResponder(passwordTextField)
    }
    
    
    
    private func deleteSession() {
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
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
    
    
}

// MARK: - LoginViewController (Configure UI)

private extension LoginViewController {
    
    func setUIEnabled(_ enabled: Bool) {
        emailTextField.isEnabled = enabled
        passwordTextField.isEnabled = enabled
        loginButton.isEnabled = enabled
        
        // adjust login button alpha
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
    
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
