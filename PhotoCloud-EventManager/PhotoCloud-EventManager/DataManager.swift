//
//  DataManager.swift
//  PhotoCloud-EventManager
//
//  Created by Negin Hodaie on 2015-03-21.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import CoreData

class DataManager: NSObject{
    
    class func getAllEvents() -> Array<EventInfo>!{
        var appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        var dataContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "EventInfo")
        request.returnsObjectsAsFaults = false
        
        var requestError:NSError? = NSError()
        var eventsArray = dataContext?.executeFetchRequest(request, error: &requestError) as Array<EventInfo>?
        if((eventsArray) != nil){
            return eventsArray!
        }else{
            return []
        }
    }
    
    class func saveEvent(event: Dictionary<String,AnyObject?>){
        var appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        var dataContext: NSManagedObjectContext = appDel.managedObjectContext!
        var dataEntity = NSEntityDescription.entityForName("EventInfo", inManagedObjectContext: dataContext);
        var eventData = NSManagedObject(entity: dataEntity!, insertIntoManagedObjectContext: dataContext)
        eventData.setValue(event["name"]?, forKey: "name")
        eventData.setValue(event["eventDate"]?, forKey: "eventDate")
        eventData.setValue(NSDate(), forKey: "createDate")
        if((event["photos"]) != nil){
            var photoData = NSKeyedArchiver.archivedDataWithRootObject(event["photos"] as Array<String>)
            eventData.setValue(photoData, forKey: "photos")
        }
        var error = NSError?()
        if(!dataContext.save(&error)){
            NSLog("error")
        }
    }
    
    class func saveImages(images : Array<ALAsset>) -> Array<String>?{
        var imageUrlsArray : Array<String>? = []
        
        // Get path to the Documents Dir.
        let paths: Array = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDir: String = paths[0] as String
        
        // Get current date and time for unique name
        var dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH-mm-ss"
        let now:NSDate = NSDate(timeIntervalSinceNow: 0)
        let theDate: String = dateFormat.stringFromDate(now)

        var counter = 0
        for info in images {
            let image = UIImage(CGImage:info.defaultRepresentation().fullResolutionImage().takeUnretainedValue())
            
            // Set URL for the full screen image
            var url = String(format: "/%@%d.png", theDate, counter)
            imageUrlsArray?.append(url)
            
            // Save the full screen image via pngData
            let pathFull: NSString = documentsDir.stringByAppendingString(url)
            let pngFullData: NSData = UIImagePNGRepresentation(image)
            pngFullData.writeToFile(pathFull, atomically: true)
            
            counter += 1
        }
        
        return imageUrlsArray?
    }
        
    class func getImageFromUrl(url: NSString) -> UIImage{
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDir: NSString = paths.objectAtIndex(0) as NSString
        let path: NSString = documentsDir.stringByAppendingString(url)
        return UIImage(contentsOfFile: path)!
    }
}