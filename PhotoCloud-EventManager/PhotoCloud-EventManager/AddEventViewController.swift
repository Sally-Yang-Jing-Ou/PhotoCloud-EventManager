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
    
    var photoUrlArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadPhotos (sender: UIButton!){
        let picker = UzysAssetsPickerController()
        picker.maximumNumberOfSelectionPhoto = 9
        picker.maximumNumberOfSelectionVideo = 0
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func createEevent (sender: UIButton!) {
        var name = eventNameTextField?.text
        var date = eventDatePicker?.date
        
        var photoData : NSData?
        if(photoUrlArray.count > 0){
            photoData = NSKeyedArchiver.archivedDataWithRootObject(photoUrlArray) as NSData
        }
        
        var eventDictionary : [String : AnyObject?] = ["name" : name, "eventDate" : date, "photos" : photoData?]
        
        DataManager.saveEvent(eventDictionary)

        self.navigationController?.popViewControllerAnimated(true)
    }

    // UIImagePickerControllerDelegate Methods
    func uzysAssetsPickerController(picker: UzysAssetsPickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        var assetsArray = (assets as Array<ALAsset>)
        
        DataManager.saveImages(assetsArray)
    }
}