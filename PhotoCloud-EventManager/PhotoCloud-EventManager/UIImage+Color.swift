//
//  UIImage+Color.swift
//  PhotoCloud-EventManager
//
//  Created by Negin Hodaie on 2015-03-21.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation

extension UIImage{
    class func imageWithColor(color: UIColor, size: CGSize!) -> UIImage? {
        var rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}