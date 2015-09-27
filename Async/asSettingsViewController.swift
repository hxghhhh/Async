//
//  asSettingsViewController.swift
//  Async
//
//  Created by Regynald Augustin on 9/26/15.
//  Copyright © 2015 HAM. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

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
        self.hackerImage.backgroundColor = UIColor(netHex: 5474020)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var logo = UIImage(named: "settings")
        logo = logo?.imageWithRenderingMode(.AlwaysTemplate)
        titleView = UIImageView(image: logo)
        self.navigationItem.titleView = titleView
        self.masterView.backgroundColor = UIColor(netHex: 0x175676)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
