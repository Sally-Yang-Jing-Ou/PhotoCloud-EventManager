//
//  UIImage+Resize.swift
//  PhotoCloud-EventManager
//
//  Created by Negin Hodaie on 2015-04-05.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    //Scale an image to new size
    class func imageByResizingImage(image: UIImage!, toNewSize newSize: CGSize!) -> UIImage!{
        var scale = UIScreen.mainScreen().scale
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, scale)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage;
    }
    
    class func imageByResizingImage(image: UIImage!, toNewHeight newHeight: CGFloat!, keepAspect aspect: Bool!) -> UIImage {
        var newWidth = image.size.width
        if(aspect == true){
            newWidth = newHeight / image.size.height * image.size.width
        }
        var newSize = CGSizeMake(newWidth, newHeight)
        return imageByResizingImage(image, toNewSize: newSize)
    }
    
    class func imageByResizingImage(image: UIImage!, toNewHeight newHeight: CGFloat!, toNewWidth newWidth: CGFloat!) -> UIImage {
        var newSize = CGSizeMake(newWidth, newHeight)
        return imageByResizingImage(image, toNewSize: newSize)
    }
    
    class func imageByResizingImageWithBiggestSide(image: UIImage!, maxSize size: CGFloat!) -> UIImage {
        var newSize: CGSize?
        if(image.size.width >= image.size.height) {
            newSize = CGSizeMake(size, size / image.size.width * image.size.height)
        }else{
            newSize = CGSizeMake(size / image.size.height * image.size.width, size)
        }
        
        return imageByResizingImage(image, toNewSize: newSize!)
    }
}