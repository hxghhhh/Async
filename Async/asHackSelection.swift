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
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //print(indexPath)
        performSegueWithIdentifier("gotoSwipeView", sender: nil)
    }

}

