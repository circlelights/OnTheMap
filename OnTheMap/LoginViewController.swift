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
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var loadingLogin: UIActivityIndicatorView!
    
    
    let udacityClient = UdacityClient().sharedInstance()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingLogin.stopAnimating()
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10.0
    }
    
    
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        userDidTapView(self)
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            debugTextLabel.text! = "Please enter username or password"
        } else {
            
            
            // MARK: TODO - Authenticate User by calling convenience method
            
            // authenticateUdacityUser(email, password) {() in  ...}
            
                udacityClient.sharedInstance().authenticateUser(email: emailTextField.text!, password: passwordTextField.text!, completionHandler: { (success, error) in
                //  success  -- implies that Udacity account id has been extracted
//                    if success {
//                        self.getStudentLocations()
//                        self.completeLogin()
//                    } else {
//                        self.displayError(error)
//                    }
                    if error != nil {
                        self.displayError(error)
                    } else if error == nil {
                        self.getStudentLocations()
                        self.completeLogin()
                    }

                })
        }
    }
    
    
//  This is the function that will enable the initial student location to be seen; however, I must pass in the correct parameters, whcih may require escaping and/or correctly using the URL.
    private func getStudentLocations() {
        ParseClient.sharedInstance().taskForGETParse(completionHandlerForGET: {(studentLocation, error) in
            if (error != nil) {
                self.displayError("Failed")
            }
        })
    }
    
    
    private func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    private func completeLogin() {
        DispatchQueue.main.async {
            self.loadingLogin.startAnimating()
            self.debugTextLabel.text = ""
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "MapandTableTabView") as! UITabBarController
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func displayError(_ errorString: String?) {
        if let errorString = errorString {
            DispatchQueue.main.async {
                self.debugTextLabel.text = errorString
            }
        }
    }
    
    
    @IBAction func userDidTapView(_ sender: AnyObject) {
        resignIfFirstResponder(emailTextField)
        resignIfFirstResponder(passwordTextField)
    }
    
    
    
//    private func deleteSession() {
//        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
//        request.httpMethod = "DELETE"
//        var xsrfCookie: HTTPCookie? = nil
//        let sharedCookieStorage = HTTPCookieStorage.shared
//        for cookie in sharedCookieStorage.cookies! {
//            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
//        }
//        if let xsrfCookie = xsrfCookie {
//            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
//        }
//        let session = URLSession.shared
//        let task = session.dataTask(with: request as URLRequest) { data, response, error in
//            if error != nil { // Handle error…
//                return
//            }
//            let range = Range(5..<data!.count)
//            let newData = data?.subdata(in: range) /* subset response data! */
//            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
//        }
//        task.resume()
//    }
    
    
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
    
//    private func escapedParameters(_ parameters: [String:AnyObject]) -> String {
//
//        if parameters.isEmpty {
//            return ""
//        } else {
//            var keyValuePairs = [String]()
//
//            for (key, value) in parameters {
//
//                // make sure that it is a string value
//                let stringValue = "\(value)"
//
//                // escape it
//                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//
//                // append it
//                keyValuePairs.append(key + "=" + "\(escapedValue!)")
//
//            }
//
//            return "?\(keyValuePairs.joined(separator: "&"))"
//        }
//    }
    
}
