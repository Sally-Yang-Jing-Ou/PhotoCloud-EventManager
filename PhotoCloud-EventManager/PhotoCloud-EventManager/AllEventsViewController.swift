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

class AllEventsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CustomSingleEventDelegate, EventCellDelegate {
    @IBOutlet weak var allEventsCollectionView: UICollectionView?
    @IBOutlet weak var addEventBarButtonItem: UIBarButtonItem?
    @IBOutlet weak var backgroundImageView: UIImageView?
    @IBOutlet weak var addEventButtonView: UIView?
    
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
        }else{
            backgroundImageView?.image = UIImage(named: "Cloud.jpg")
        }
        eventsArray = DataManager.getAllEvents()
        
        if(eventsArray.count == 0){
            addEventButtonView?.hidden = false
        }else{
            addEventButtonView?.hidden = true
        }
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
        return CGSizeMake(collectionView.frame.size.width, 83)
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(6)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("reuseEventCell", forIndexPath: indexPath) as EventCell
        var currentEvent = eventsArray[indexPath.row]
        
        var dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "MMMM dd, yyyy"
        let theDate: String = dateFormat.stringFromDate(currentEvent.eventDate)
        
        cell.eventNameLabel?.text = currentEvent.name
        cell.eventDateLabel?.text = theDate
        cell.eventObject = currentEvent as NSManagedObject
        cell.delegate = self
        cell.layer.borderWidth=0.6
        cell.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.3).CGColor
//        cell.layer.shadowOpacity = 0.4
//        cell.layer.masksToBounds = false
//        cell.layer.shadowColor = UIColor.whiteColor().CGColor
        
        
        var photoData = currentEvent.photos as NSData?
        if((photoData) != nil){
            var photoArray = NSKeyedUnarchiver.unarchiveObjectWithData(photoData!) as Array<String>
            let url = photoArray[0] as NSString
            cell.eventImageView?.image = DataManager.getImageFromUrl(url)
        }else{
            cell.eventImageView?.image = UIImage.imageWithColor(UIColor.blueColor(), size: CGSizeMake(100, 72))
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
    
    //MARK: EventCell Delegate
    func eventCell(eventCell: EventCell, willDeleteEvent event: NSManagedObject) {
        var deleteAlertController = UIAlertController(title: nil, message: "Are you sure you want to delete this event?", preferredStyle: UIAlertControllerStyle.Alert)
        
        var yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive) { (action) -> Void in
            DataManager.deleteEvent(event)
            self.eventsArray = DataManager.getAllEvents()
            self.allEventsCollectionView?.reloadData()
            
            
            if(self.eventsArray.count == 0){
                self.addEventButtonView?.hidden = false
            }else{
                self.addEventButtonView?.hidden = true
            }
        }
        
        var noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil)
        
        deleteAlertController.addAction(yesAction)
        deleteAlertController.addAction(noAction)
        
        self.presentViewController(deleteAlertController, animated: true, completion: nil)
    }
}