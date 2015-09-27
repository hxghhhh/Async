//
//  asChatViewController.swift
//  Async
//
//  Created by Regynald Augustin on 9/26/15.
//  Copyright © 2015 HAM. All rights reserved.
//

import UIKit

class asChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var testData:[Int] = [1,2,3,4,5,6,7,8,9]

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
    }
    
    //TableView - Delegates
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "matchCell")
        
        cell.textLabel!.text = "Working"
        
        return cell
    } 

}
