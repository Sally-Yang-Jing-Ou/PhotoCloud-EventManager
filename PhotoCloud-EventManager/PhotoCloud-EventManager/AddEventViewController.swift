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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadPhotos (sender: UIButton!){
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        picker.delegate = self
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func createEevent (sender: UIButton!) {
        var name = eventNameTextField?.text;
        var date = eventDatePicker?.date;
        
        var appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        var dataContext: NSManagedObjectContext = appDel.managedObjectContext!
        var dataEntity = NSEntityDescription.entityForName("EventInfo", inManagedObjectContext: dataContext);
        var eventData = NSManagedObject(entity: dataEntity!, insertIntoManagedObjectContext: dataContext)
        eventData.setValue(name, forKey: "name")
        eventData.setValue(date, forKey: "eventDate")
        eventData.setValue(NSDate(), forKey: "createDate")
        var error = NSError?()
        if(!dataContext.save(&error)){
            NSLog("error")
        }
    }

    // UIImagePickerControllerDelegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}