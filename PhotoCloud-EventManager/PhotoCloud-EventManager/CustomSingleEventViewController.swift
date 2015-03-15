//
//  CustomSingleEventViewController.swift
//  PhotoCloud-EventManager
//
//  Created by Sally Yang Jing Ou on 2015-03-15.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import UIKit

class CustomSingleEventViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var backgroundImageView: UIImageView?
    @IBOutlet weak var customSingleEventCollectionView: UICollectionView?
    
    var eventInfo: EventInfo?
    var photoArray:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var photoData = eventInfo?.photos
        if((photoData) != nil){
            photoArray = NSKeyedUnarchiver.unarchiveObjectWithData(photoData!) as NSArray
            let url = photoArray[0] as NSString
            backgroundImageView?.image = getImageFromUrl(url)
        }
        self.title = eventInfo?.name
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        customSingleEventCollectionView?.reloadData()
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
        cell.singleEventImageView?.image = getImageFromUrl(url)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!,sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var randomWidth = CGFloat(arc4random_uniform(250) + 150)
        var randomHeight = CGFloat(arc4random_uniform(305) + 220)
        
        return CGSizeMake(randomWidth, randomHeight)
    }
    
    func collectionView(collectionView: UICollectionView!,layout collectionViewLayout: UICollectionViewLayout!,insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var top = CGFloat(arc4random_uniform(50) + 45)
        var left = CGFloat(arc4random_uniform(20) + 10)
        var bottom = CGFloat(arc4random_uniform(50) + 45)
        var right = CGFloat(arc4random_uniform(20) + 10)
        var sectionInsets = UIEdgeInsetsMake(top, left, bottom, right)
        
        return sectionInsets
    }
    
    
    func getImageFromUrl(url: NSString) -> UIImage{
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDir: NSString = paths.objectAtIndex(0) as NSString
        let path: NSString = documentsDir.stringByAppendingString(url)
        return UIImage(contentsOfFile: path)!
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