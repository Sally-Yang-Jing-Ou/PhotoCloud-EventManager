//
//  AllEventsViewController.swift
//  PhotoCloud-EventManager
//
//  Created by Sally Yang Jing Ou on 2015-03-14.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AllEventsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var allEventsCollectionView: UICollectionView?
    @IBOutlet weak var addEventBarButtonItem: UIBarButtonItem?
    
    var eventsArray: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        var dataContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "EventInfo")
        request.returnsObjectsAsFaults = false
        
        var requestError:NSError? = NSError()
        eventsArray = dataContext?.executeFetchRequest(request, error: &requestError) as NSArray!
        allEventsCollectionView?.reloadData()
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
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("reuseEventCell", forIndexPath: indexPath) as EventCell
        var currentEvent = eventsArray[indexPath.row] as EventInfo
        cell.eventNameLabel?.text = currentEvent.name
 
        cell.eventImageView?.image = getImageWithColor(UIColor.blueColor(), size: CGSizeMake(100, 60))

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let singleEventViewController = storyboard?.instantiateViewControllerWithIdentifier("CustomSingleEventViewController") as CustomSingleEventViewController
        singleEventViewController.eventInfo = eventsArray[indexPath.row] as? EventInfo
        self.navigationController?.pushViewController(singleEventViewController, animated: true)
        
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