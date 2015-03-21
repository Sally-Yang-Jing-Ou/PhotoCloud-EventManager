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

class AllEventsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CustomSingleEventDelegate {
    @IBOutlet weak var allEventsCollectionView: UICollectionView?
    @IBOutlet weak var addEventBarButtonItem: UIBarButtonItem?
    @IBOutlet weak var backgroundImageView: UIImageView?
    
    var eventsArray: Array<EventInfo>! = []
    var backgroundImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView?.image = UIImage.imageWithColor(UIColor.grayColor(), size: backgroundImageView?.frame.size)
        eventsArray = DataManager.getAllEvents()
        if(eventsArray.count > 0){
            var firstEvent = eventsArray[0];
            var photoData = firstEvent.photos as NSData?
            if((photoData) != nil){
                var photoArray = NSKeyedUnarchiver.unarchiveObjectWithData(photoData!) as Array<String>
                let url = photoArray[0] as NSString
                backgroundImageView?.image = DataManager.getImageFromUrl(url)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if((backgroundImage) != nil){
            backgroundImageView?.image = backgroundImage
        }
        eventsArray = DataManager.getAllEvents()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
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
        singleEventViewController.delegate = self;
        self.navigationController?.pushViewController(singleEventViewController, animated: true)
    }
    
    //MARK: CustomSingleEvent Delegate
    func customSingleEvent(customSingleEvent: CustomSingleEventViewController, didReturnPhoto photo: UIImage?) {
        backgroundImage = photo
    }
}