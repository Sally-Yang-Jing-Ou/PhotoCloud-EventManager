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

class AddEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var uploadPhotosButton: UIButton?
    @IBOutlet weak var createEventButton: UIButton?
    
    @IBOutlet weak var eventNameTextField: UITextField?
    @IBOutlet weak var eventDatePicker: UIDatePicker?
    
    var photoUrlArray: NSMutableArray = []
    var photoCounter: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadPhotos (sender: UIButton!){
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        picker.delegate = self
        picker.allowsEditing = false
        photoCounter = 0
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
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
        // Get path to the Documents Dir.
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDir: NSString = paths.objectAtIndex(0) as NSString
        
        // Get current date and time for unique name
        var dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let now:NSDate = NSDate(timeIntervalSinceNow: 0)
        let theDate: NSString = dateFormat.stringFromDate(now)
        
        // Set URL for the full screen image
        var url = NSString(format: "/%@%d.png", theDate, photoCounter)
        photoUrlArray.addObject(url)
        
        // Save the full screen image via pngData
        let pathFull: NSString = documentsDir.stringByAppendingString(url)
        let pngFullData: NSData = UIImagePNGRepresentation(image)
        pngFullData.writeToFile(pathFull, atomically: true)
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        photoCounter = photoCounter + 1;
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}