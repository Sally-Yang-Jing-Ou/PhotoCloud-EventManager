//
//  CustomSingleEventViewController.swift
//  PhotoCloud-EventManager
//
//  Created by Sally Yang Jing Ou on 2015-03-15.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import UIKit
import Social

protocol CustomSingleEventDelegate: class{
    func customSingleEvent(customSingleEvent:CustomSingleEventViewController, didReturnPhoto photo:UIImage?)
}

class CustomSingleEventViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIActionSheetDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView?
    @IBOutlet weak var customSingleEventCollectionView: UICollectionView?
    
    var eventInfo: EventInfo?
    var photoArray:NSArray = []
    weak var delegate:CustomSingleEventDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var photoData = eventInfo?.photos
        if((photoData) != nil){
            photoArray = NSKeyedUnarchiver.unarchiveObjectWithData(photoData!) as NSArray
            let url = photoArray[0] as NSString
            var backgroundImage = DataManager.getImageFromUrl(url)
            backgroundImageView?.image = backgroundImage
            if((delegate) != nil){
                delegate?.customSingleEvent(self, didReturnPhoto: backgroundImage)
            }
        }
        self.title = eventInfo?.name
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //customSingleEventCollectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return photoArray.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    //3
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ReuseSingleEventPhotoCell", forIndexPath: indexPath) as SingleEventPhotoCell
        
        let url = photoArray[indexPath.section] as NSString
        cell.singleEventImageView?.image = DataManager.getImageFromUrl(url)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!,sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var resizeImage: UIImage?
        let url = photoArray[indexPath.section] as NSString
        resizeImage = DataManager.getImageFromUrl(url)

        var randomWidth = CGFloat(arc4random_uniform(350) + 200)
        var imageWidth = resizeImage?.size.width
        var imageHeight = resizeImage?.size.height
        
        if (imageWidth > imageHeight) {
            imageWidth = randomWidth
            imageHeight = imageWidth! / 1.6
        } else if (imageWidth < imageHeight) {
            imageWidth = randomWidth
            imageHeight = imageWidth! * 1.6
        } else {
            imageWidth = randomWidth
            imageHeight = imageWidth
        }
        
        return CGSizeMake(imageWidth!, imageHeight!)
    }
    
    func collectionView(collectionView: UICollectionView!,layout collectionViewLayout: UICollectionViewLayout!,insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var top = CGFloat(arc4random_uniform(50) + 45)
        var left = CGFloat(arc4random_uniform(20) + 10)
        var bottom = CGFloat(arc4random_uniform(50) + 45)
        var right = CGFloat(arc4random_uniform(20) + 10)
        var sectionInsets = UIEdgeInsetsMake(top, left, bottom, right)
        
        return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as SingleEventPhotoCell
        var image = convertImageToBlurViewImage(cell.singleEventImageView?.image!)

        var alertViewController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alertViewController.addAction(cancelAction)
        
        let facebookShareAction = UIAlertAction(title: "Share to Facebook", style: UIAlertActionStyle.Default) { (action) -> Void in
            var facebookShareViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookShareViewController.addImage(image)
            
            self.presentViewController(facebookShareViewController, animated: true, completion: nil)
        }
        alertViewController.addAction(facebookShareAction)
        
        let twitterShareAction = UIAlertAction(title: "Share to Twitter", style: UIAlertActionStyle.Default) { (action) -> Void in
            var twitterShareViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterShareViewController.addImage(image)
            
            self.presentViewController(twitterShareViewController, animated: true, completion: nil)
        }
        
        alertViewController.addAction(twitterShareAction)

        self.presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    func convertImageToBlurViewImage(image:UIImage!) -> UIImage{
        var containerView = UIView(frame: self.view.frame)
        
        var backgroundImageView = UIImageView(image: image)
        backgroundImageView.frame = containerView.bounds
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var backgroundVisualEffectView = UIVisualEffectView(effect: blurEffect)
        backgroundVisualEffectView.frame = containerView.bounds
        
        var imageSize : CGSize
        if(image.size.width <= image.size.height){
            //Vertical or Square
            var height = containerView.frame.size.height / 1.5
            imageSize = CGSizeMake(height / image.size.height * image.size.width, height)
        }else{
            //Horizontal
            var width = containerView.frame.size.width
            imageSize = CGSizeMake(width, width / image.size.width * image.size.height)
        }
        
        var mainImageView = UIImageView(image: image)
        mainImageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height)
        mainImageView.center = backgroundImageView.center
        mainImageView.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.8).CGColor
        mainImageView.layer.borderWidth = 4
        mainImageView.layer.masksToBounds = false
        mainImageView.layer.shadowColor = UIColor.blackColor().CGColor
        mainImageView.layer.shadowOpacity = 0.5
        
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(backgroundVisualEffectView)
        containerView.addSubview(mainImageView)
        
        var rect = containerView.frame;
        
        UIGraphicsBeginImageContextWithOptions(rect.size,true,0);
        containerView.drawViewHierarchyInRect(rect, afterScreenUpdates: true)
        var capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //self.view = containerView
        
        return capturedScreen
    }
}