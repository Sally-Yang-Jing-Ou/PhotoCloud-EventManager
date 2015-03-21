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
    
    var eventsArray: Array<EventInfo>! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        eventsArray = DataManager.getAllEvents()
        
        allEventsCollectionView?.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, 83)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("reuseEventCell", forIndexPath: indexPath) as EventCell
        var currentEvent = eventsArray[indexPath.row]
        cell.eventNameLabel?.text = currentEvent.name
        
        var photoData = currentEvent.photos as NSData?
        if((photoData) != nil){
            var photoArray = NSKeyedUnarchiver.unarchiveObjectWithData(photoData!) as Array<String>
            let url = photoArray[0] as NSString
            cell.eventImageView?.image = DataManager.getImageFromUrl(url)
        }else{
            cell.eventImageView?.image = UIImage.imageWithColor(UIColor.blueColor(), size: CGSizeMake(100, 60))
        }

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let singleEventViewController = storyboard?.instantiateViewControllerWithIdentifier("CustomSingleEventViewController") as CustomSingleEventViewController
        singleEventViewController.eventInfo = eventsArray[indexPath.row]
        self.navigationController?.pushViewController(singleEventViewController, animated: true)
    }
}