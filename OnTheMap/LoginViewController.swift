//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Developer2017 on 4/7/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var udacityWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL (string: "https://www.udacity.com")
        let requestObj = URLRequest(url: url! as URL)
        udacityWebView.loadRequest(requestObj)
    }
    
    //Try loading this way as well, but try from viewDidLoad first
    func loadHTMLString(_ string: String, baseURL: URL?) {
        
    }
    
}
