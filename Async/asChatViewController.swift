//
//  asChatViewController.swift
//  Async
//
//  Created by Regynald Augustin on 9/26/15.
//  Copyright © 2015 HAM. All rights reserved.
//

import UIKit

class asChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var matchedUsers = [PFObject]()

    @IBOutlet var matchTableView: UITableView!

    var titleView: UIImageView? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var logo = UIImage(named: "chat")
        logo = logo?.imageWithRenderingMode(.AlwaysTemplate)
        titleView = UIImageView(image: logo)
        self.navigationItem.titleView = titleView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var logo = UIImage(named: "chat")
        logo = logo?.imageWithRenderingMode(.AlwaysTemplate)
        titleView = UIImageView(image: logo)
        self.navigationItem.titleView = titleView
        // Do any additional setup after loading the view.
        let query = PFQuery(className: "_User")


        let user = PFUser.currentUser()!
        let tmp = user["fbID"]
        query.whereKey("fbID", notEqualTo: tmp).whereKey("fbID", containedIn: user["liked"] as! [PFObject]).whereKey("liked", containsAllObjectsInArray: [tmp])
        query.findObjectsInBackgroundWithBlock { (users, error) -> Void in
            print(users)
            if users != nil {
                for user in users! {
                    self.matchedUsers.append(user)
//                    let username = user["username"] as? String ?? "Anon"
//                    if(!self.matchedUsers.contains(username)){
//                        self.matchedUsers.append(username)
//                    }
                   
                }
                 self.matchTableView.reloadData()
                
            } else {
                
            }

        }
        
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    //TableView - Delegates
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedUsers.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "matchCell")
        
        cell.textLabel!.text = matchedUsers[indexPath.row]["username"] as? String ?? "Anon"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("asSettingsViewController") as? asSettingsViewController {
//            self.presentViewController(vc, animated: true, completion: { () -> Void in
//                print("good")
//            })
//        }
        let user = matchedUsers[indexPath.row]
        let id = user["fbID"]
        let url = NSURL(string: "fb://\(id)")
        UIApplication.sharedApplication().openURL(url!)
        print(user)
    }

}
