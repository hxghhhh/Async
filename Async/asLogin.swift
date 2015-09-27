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

    func parseLogin() {
        do {
            try PFUser.logInWithUsername(FBSDKProfile.currentProfile().name, password: "1")
        } catch _ {
            print("fuckshit")
        }
        /*
        PFFacebookUtils.logInWithFacebookId(FBSDKProfile.currentProfile().userID, accessToken: FBSDKAccessToken.currentAccessToken().tokenString, expirationDate: FBSDKAccessToken.currentAccessToken().expirationDate) { (user, error) -> Void in
            if user != nil {
            
            } else {

            
            }
        }
*/
    }
    func onProfileUpdated(notification: NSNotification)
    {
        // Current profile here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)

        // Do any additional setup after loading the view, typically from a nib.
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onProfileUpdated:", name:FBSDKProfileDidChangeNotification, object: nil)
        if(FBSDKAccessToken.currentAccessToken() != nil){
            parseLogin()
            self.performSegueWithIdentifier("gotoEventSelection", sender: self)
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loginButton.delegate = self
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            FBSDKAccessToken.refreshCurrentAccessToken { (connection, result, error) -> Void in
                print("Token duration extended")
                self.parseLogin()
                self.performSegueWithIdentifier("gotoEventSelection", sender: self)
            }
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
       // let profile = FBSDKProfile.currentProfile()
        
        // Send request to Facebook
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id,name"])
            graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
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
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        //user has successfully logged in
    }
    
    
    func createNewUser(newUserName:String, id:String) {
        var user = PFUser()
        user.username = newUserName
        user.password = "1"
        user["fbID"] = id
        user["visited"] = []
        user["liked"] = []
        user["name"] = newUserName
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                print(errorString)
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                print(newUserName + "Has been saved!!")
                self.parseLogin()
                self.performSegueWithIdentifier("gotoEventSelection", sender: self)
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
//        
//        let query = PFQuery(className: "_PFUser")
//        let userQuery = PFUser.query()
//        userQuery?.whereKey("FBId", equalTo: scimitar);
//        userQuery?.findObjectsInBackgroundWithBlock({ ([PFObject]?, NSError?) -> Void in
//            <#code#>
//        })
//        
//        return true
//    }
        
}