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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UICollectionViewDataSource
    
    //1
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 9
    }
    
    //2
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    //3
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ReuseSingleEventPhotoCell", forIndexPath: indexPath) as SingleEventPhotoCell
        //2
        //let flickrPhoto = photoForIndexPath(indexPath)
        // cell.backgroundColor = UIColor.blackColor()
        //3
        //cell.imageView.image = flickrPhoto.thumbnail
        cell.singleEventImageView?.image = getImageWithColor(UIColor.blueColor(), size: CGSizeMake(100, 60))
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    //1
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!,sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var randomWidth = CGFloat(arc4random_uniform(250) + 150)
        var randomHeight = CGFloat(arc4random_uniform(305) + 220)
        
        return CGSizeMake(randomWidth, randomHeight)
    }
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    //        var randomSpacing = CGFloat(arc4random_uniform(20) + 10)
    //
    //        return randomSpacing
    //    }
    
    func collectionView(collectionView: UICollectionView!,layout collectionViewLayout: UICollectionViewLayout!,insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var top = CGFloat(arc4random_uniform(50) + 45)
        var left = CGFloat(arc4random_uniform(20) + 10)
        var bottom = CGFloat(arc4random_uniform(50) + 45)
        var right = CGFloat(arc4random_uniform(20) + 10)
        var sectionInsets = UIEdgeInsetsMake(top, left, bottom, right)
        
        return sectionInsets
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