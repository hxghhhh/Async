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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            FBSDKAccessToken.refreshCurrentAccessToken { (connection, result, error) -> Void in
                print("Token duration extended")
            }
             self.performSegueWithIdentifier("gotoEventSelection", sender: self)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(FBSDKAccessToken.currentAccessToken() != nil){
            self.performSegueWithIdentifier("gotoEventSelection", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        //create userObject here
        print(result)
        // Create request for user's Facebook data
        let request = FBSDKGraphRequest(graphPath:"me", parameters:nil)
        
        // Send request to Facebook
        request.startWithCompletionHandler {
            
            (connection, result, error) in
            
            if error != nil {
                // Some error checking here
            }
            else if let userData = result as? [String:AnyObject] {
                
                // Access user data
                let username = userData["name"] as? String
                let email = userData["email"] as? String
                let userAge = userData["age_range"] as? String
                print(username)
                
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        //user has successfully logged in
    }
    
    
    func createNewUser() {
        var user = PFUser()
        user.username = "myUsername"
        user.email = "email@example.com"
        // other fields can be set just like with PFObject
     
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        }
    }
}