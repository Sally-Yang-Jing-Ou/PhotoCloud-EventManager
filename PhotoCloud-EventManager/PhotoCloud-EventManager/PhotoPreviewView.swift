//
//  PhotoPreviewView.swift
//  PhotoCloud-EventManager
//
//  Created by Negin Hodaie on 2015-04-05.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import UIKit

class PhotoPreviewView: UIView {
    
    private var imageViewArray: Array<UIImageView> = []
    private var displayView: UIView = UIView(frame: CGRectMake(0, 0, 0, 0))
    
    var preferredImageOffset: Float = 20 {
        didSet {
            deleteImages()
            refreshImages()
        }
    }
    
    var imageArray: Array<UIImage> = [] {
        willSet(newImageArray) {
            deleteImages()
        }
        didSet {
            refreshImages()
        }
    }
    
    //MARK: Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    //MARK: Helper functions
    private func setupViews() {
        self.addSubview(displayView)
        self.clipsToBounds = true
    }
    
    private func deleteImages(){
        for imageView in imageViewArray {
            imageView.removeFromSuperview()
        }
        imageViewArray.removeAll(keepCapacity: false)
    }
    
    private func refreshImages(){
        var numberOfViews: NSInteger = imageArray.count
        var spacesBetweenImages = min(Float(self.frame.size.width) / Float(numberOfViews), preferredImageOffset)
        var xPosition: Float = 0
        var maxX: Float = 0
        for image in imageArray {
            var newImage = UIImage.imageByResizingImage(image, toNewHeight: self.frame.size.height, keepAspect: true)
            var imageView = UIImageView(image: newImage)
            imageView.frame = CGRectMake(CGFloat(xPosition), 0, imageView.frame.size.width, imageView.frame.size.height)
            imageView.layer.shadowColor = UIColor.blackColor().CGColor
            imageView.layer.shadowOpacity = 1
            imageView.layer.masksToBounds = false
            displayView.addSubview(imageView)
            
            xPosition = xPosition + spacesBetweenImages
            maxX = Float(CGRectGetMaxX(imageView.frame))
            
            imageViewArray.append(imageView)
        }
        displayView.frame = CGRectMake(0, 0, CGFloat(maxX), self.frame.size.height)
        displayView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
    }
    
}
