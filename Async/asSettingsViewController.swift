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
    @IBOutlet var masterView: UIView!
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
    
    func createPictureView(url: NSURL) {
        let height = min(self.hackerImage.frame.width, self.hackerImage.frame.height)*0.8
        let width = height
        let profile_view = UIImageView(frame: CGRectMake((self.hackerImage.bounds.width - width)*0.5, 0.05*self.hackerImage.bounds.height, width, height))
        profile_view.image = UIImage(data: NSData(contentsOfURL: url)!)

        profile_view.layer.borderWidth=1.0
        profile_view.layer.masksToBounds = false
        profile_view.layer.borderColor = UIColor.whiteColor().CGColor
        profile_view.layer.cornerRadius = profile_view.frame.size.height/2
        profile_view.clipsToBounds = true
        self.hackerImage.addSubview(profile_view)
        self.hackerImage.backgroundColor = UIColor(netHex: 0x175676)
        self.hackerImage.alpha = 0.9
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var logo = UIImage(named: "settings")
        logo = logo?.imageWithRenderingMode(.AlwaysTemplate)
        titleView = UIImageView(image: logo)
        self.navigationItem.titleView = titleView
        //self.masterView.backgroundColor = UIColor(netHex: 0x175676)
        // Do any additional setup after loading the view.

        if (FBSDKAccessToken.currentAccessToken() != nil) {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id,name,age_range,picture.width(\(1080)).height(\(1080))"])
            graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
                if error != nil {
                    print("Error: \(error)")
                } else {
                    
                    let url = NSURL(string: result.valueForKey("picture")!.valueForKey("data")!.valueForKey("url") as! String)
                    self.createPictureView(url!)

                    print("fetched user: \(result)")
                    let profile = FBSDKProfile.currentProfile()

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
