//
//  asSettingsViewController.swift
//  Async
//
//  Created by Regynald Augustin on 9/26/15.
//  Copyright © 2015 HAM. All rights reserved.
//

import UIKit

class asSettingsViewController: UIViewController {

    @IBOutlet var hackerImage: UIImageView!
    @IBOutlet var hackerName: UILabel!
    @IBOutlet var hackerAge: UILabel!
    @IBOutlet var hackerDescription: UILabel!
    @IBOutlet var hackerSkill: UILabel!
    
    
    
    var titleView: UIImageView? = nil
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var logo = UIImage(named: "settings")
        logo = logo?.imageWithRenderingMode(.AlwaysTemplate)
        titleView = UIImageView(image: logo)
        self.navigationItem.titleView = titleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var logo = UIImage(named: "settings")
        logo = logo?.imageWithRenderingMode(.AlwaysTemplate)
        titleView = UIImageView(image: logo)
        self.navigationItem.titleView = titleView
        // Do any additional setup after loading the view.

        if (FBSDKAccessToken.currentAccessToken() != nil) {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
                if error != nil {
                    print("Error: \(error)")
                } else {
                    print("fetched user: \(result)")
                    let profile = FBSDKProfile.currentProfile()
                
                    //let imageString = result.valueForKey("picture")?.valueForKey("data")?.valueForKey("url") as? String
                    //let url = NSURL(string: imageString!)
                    
                    let userName : NSString = result.valueForKey("name") as? NSString ?? "Empty"
                    self.hackerName.text = userName as String
                    print("User Name is: \(userName)")
                    
                    let userEmail : NSString = result.valueForKey("email") as? NSString ?? "Empty"
                    print("User Email is: \(userEmail)")
                    
                    let ageRange:NSString = result["age_range"] as? NSString ?? "Empty"
                     print("User agerange is: \(ageRange)")
                }
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userPressedLogoutBtn(sender: AnyObject) {
        FBSDKLoginManager().logOut()
        performSegueWithIdentifier("gotoLogin", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
