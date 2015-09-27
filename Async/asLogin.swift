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
    
    let loginButton = FBSDKLoginButton()
    var profile = FBSDKProfile.currentProfile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onProfileUpdate", name: FBSDKProfileDidChangeNotification, object: nil)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loginButton.delegate = self
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
    
    func onProfileUpdate() {
        profile = FBSDKProfile.currentProfile()
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        //create userObject here
        print(result)
        // Create request for user's Facebook data
        self.profile = FBSDKProfile.currentProfile()
        let request = FBSDKGraphRequest(graphPath:"me", parameters:nil)
        
        // Send request to Facebook
        request.startWithCompletionHandler {
            
            (connection, result, error) in
            
            if error != nil {
                // Some error checking here
                print("error")
            }
            else if let userData = result as? [String:AnyObject] {
                
                // Access user data
                let username = userData["name"] as? String
                let fbID = userData["id"] as? String
                self.createNewUser(username!, id: fbID!)
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        //user has successfully logged in
    }
    
    
    func createNewUser(newUserName:String, id:String) {
        let user = PFUser()
        user.username = newUserName
        user.password = "1"
        user["fbID"] = id
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                print(errorString)
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                print(newUserName + "Has been saved!!")
            }
        }
    }
    
//    func userAlreadyExist() -> Bool {
//        let query = PFUser.query()
//        guard let profile = self.profile else {
//            return false
//        }
//        print(profile.userID)
//        var userExists = false
//        query?.whereKey("fbID", equalTo: profile.userID)
//        query?.getFirstObjectInBackgroundWithBlock(){ (object, error) -> Void in
//            if object != nil {
//                userExists = true
//            } else {
//                userExists = false
//            }
//            return userExists
//        }
//    }
    
}