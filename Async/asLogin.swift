//
//  asLogin.swift
//  Async
//
//  Created by Hugh A. Miles on 9/25/15.
//  Copyright © 2015 HAM. All rights reserved.
//

import Foundation
import UIKit

class asLogin: UIViewController, FBSDKLoginButtonDelegate{
    
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoLabel.setTextColor(UIColor(netHex: 0x4D474A), before: "Sync")
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    @IBAction func onClick(sender: AnyObject) {
    }
}