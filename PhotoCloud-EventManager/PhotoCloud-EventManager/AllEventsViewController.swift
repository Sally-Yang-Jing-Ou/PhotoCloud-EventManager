//
//  AllEventsViewController.swift
//  PhotoCloud-EventManager
//
//  Created by Sally Yang Jing Ou on 2015-03-14.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import UIKit

class AllEventsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var allEventsCollectionView: UICollectionView?
    var eventsArray = ["event1", "event2", "event3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, 100)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("reuseEventCell", forIndexPath: indexPath) as    EventCell
        cell.eventNameLabel?.text = eventsArray[indexPath.row]
        
//        var w = cell.eventImageView?.frame.size.width as CGFloat?
//        var h = cell.eventImageView?.frame.size.height as CGFloat?
//
//        var s:CGSize = CGSizeMake(w, h)
        
        cell.eventImageView?.image = getImageWithColor(UIColor.blueColor(), size: CGSizeMake(100, 60))
        
//        var view: UIView = UIView()
//        view.backgroundColor = UIColor.blueColor();
//        cell.backgroundView=view
        return cell
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        var rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    
    
    
    
    
}