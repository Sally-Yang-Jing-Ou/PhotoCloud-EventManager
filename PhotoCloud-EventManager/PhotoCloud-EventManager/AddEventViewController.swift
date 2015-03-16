//
//  AddEventViewController.swift
//  PhotoCloud-EventManager
//
//  Created by Sally Yang Jing Ou on 2015-03-14.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddEventViewController: UIViewController, UINavigationControllerDelegate, UzysAssetsPickerControllerDelegate{
    @IBOutlet weak var uploadPhotosButton: UIButton?
    @IBOutlet weak var createEventButton: UIButton?
    
    @IBOutlet weak var eventNameTextField: UITextField?
    @IBOutlet weak var eventDatePicker: UIDatePicker?
    
    var photoUrlArray: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadPhotos (sender: UIButton!){

        let picker = UzysAssetsPickerController()
        picker.maximumNumberOfSelectionPhoto = 9
        picker.maximumNumberOfSelectionVideo = 0
        picker.delegate = self
        //let picker = UIImagePickerController()
//        picker.sourceType = .PhotoLibrary
//        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
//        picker.delegate = self
//        picker.allowsEditing = false
         self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func createEevent (sender: UIButton!) {
        var name = eventNameTextField?.text
        var date = eventDatePicker?.date
        
        var appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        var dataContext: NSManagedObjectContext = appDel.managedObjectContext!
        var dataEntity = NSEntityDescription.entityForName("EventInfo", inManagedObjectContext: dataContext);
        var eventData = NSManagedObject(entity: dataEntity!, insertIntoManagedObjectContext: dataContext)
        eventData.setValue(name, forKey: "name")
        eventData.setValue(date, forKey: "eventDate")
        eventData.setValue(NSDate(), forKey: "createDate")
        if(photoUrlArray.count > 0){
            var photoData = NSKeyedArchiver.archivedDataWithRootObject(photoUrlArray)
            eventData.setValue(photoData, forKey: "photos")
        }
        var error = NSError?()
        if(!dataContext.save(&error)){
            NSLog("error")
        }
    }

    // UIImagePickerControllerDelegate Methods
    func uzysAssetsPickerController(picker: UzysAssetsPickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        var counter = 0
        var assetsArray = (assets as NSArray)
        for info in assetsArray {
            var ciImage = info as ALAsset
            var image = UIImage(CGImage:ciImage.defaultRepresentation().fullResolutionImage().takeRetainedValue())
            //let image: UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
            // Get path to the Documents Dir.
            let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDir: NSString = paths.objectAtIndex(0) as NSString
            
            // Get current date and time for unique name
            var dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd-HH-mm-ss"
            let now:NSDate = NSDate(timeIntervalSinceNow: 0)
            let theDate: NSString = dateFormat.stringFromDate(now)
            
            // Set URL for the full screen image
            var url = NSString(format: "/%@%d.png", theDate, counter)
            photoUrlArray.addObject(url)
            
            // Save the full screen image via pngData
            let pathFull: NSString = documentsDir.stringByAppendingString(url)
            let pngFullData: NSData = UIImagePNGRepresentation(image)
            pngFullData.writeToFile(pathFull, atomically: true)
            
            counter += 1
        
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}