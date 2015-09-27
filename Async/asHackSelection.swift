//
//  ViewController.swift
//  Async
//
//  Created by Hugh A. Miles on 9/25/15.
//  Copyright © 2015 HAM. All rights reserved.
//

import UIKit
import QuartzCore

class asEventSelection: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var hacks:[String]  = ["hackGT", "hackCUU", "hackNY", "hackTX", "VandyHacks", "CalHacks"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return hacks.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        let cell:asHackCell = collectionView.dequeueReusableCellWithReuseIdentifier("hackCell", forIndexPath: indexPath) as! asHackCell
       
        cell.hackName.text = hacks[indexPath.row]
        cell.hackImage.image = UIImage(named: hacks[indexPath.row])

//        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:view.bounds];
//        view.layer.masksToBounds = NO;
//        view.layer.shadowColor = [UIColor blackColor].CGColor;
//        view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//        view.layer.shadowOpacity = 0.5f;
//        view.layer.shadowPath = shadowPath.CGPath;
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.layer.shadowColor = UIColor.grayColor().CGColor
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).CGPath
        // cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 20.0).CGPath
        // cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        // cell.layer.shadowOpacity = 1.0
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 10
        cell.layer.masksToBounds = false
        //cell.clipsToBounds = false
        
//        cell.layer.shadowPath = UIBezierPath.init(roundedRect: cell.bounds, byRoundingCorners:, cornerRadii:cell.contentView.layer.cornerRadius)
        //cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //print(indexPath)
        performSegueWithIdentifier("gotoSwipeView", sender: nil)
    }

}

