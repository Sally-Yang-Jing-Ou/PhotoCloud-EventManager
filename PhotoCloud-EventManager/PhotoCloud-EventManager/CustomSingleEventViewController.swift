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
            backgroundImageView?.image = DataManager.getImageFromUrl(url)
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
        cell.singleEventImageView?.image = DataManager.getImageFromUrl(url)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!,sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var resizeImage: UIImage?
        let url = photoArray[indexPath.section] as NSString
        resizeImage = getImageFromUrl(url)

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
}