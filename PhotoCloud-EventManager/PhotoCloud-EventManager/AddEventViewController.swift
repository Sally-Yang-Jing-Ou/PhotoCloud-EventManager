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

class AddEventViewController: UIViewController, UINavigationControllerDelegate, UzysAssetsPickerControllerDelegate, UITextFieldDelegate{
    @IBOutlet weak var uploadPhotosButton: UIButton?
    @IBOutlet weak var createEventButton: UIButton?
    
    @IBOutlet weak var eventNameTextField: UITextField?
    @IBOutlet weak var eventDatePicker: UIDatePicker?
    
    @IBOutlet weak var photoPreviewView: PhotoPreviewView?
    @IBOutlet weak var photoPreviewHeight: NSLayoutConstraint?
    @IBOutlet weak var photoPreviewTopSpace: NSLayoutConstraint?
    
    var photoUrlArray: Array<String>? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createEventButton?.layer.cornerRadius = (createEventButton?.frame.size.height)! / 2
        uploadPhotosButton?.layer.cornerRadius = (uploadPhotosButton?.frame.size.height)! / 2
        
        self.eventNameTextField?.delegate = self
        self.photoPreviewHeight?.constant = 0
        self.photoPreviewTopSpace?.constant = 0
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
        if(photoUrlArray?.count > 0){
            photoData = NSKeyedArchiver.archivedDataWithRootObject(photoUrlArray!) as NSData
        }
        
        var eventDictionary : [String : AnyObject?] = ["name" : name, "eventDate" : date, "photos" : photoData?]
        
        DataManager.saveEvent(eventDictionary)

        self.navigationController?.popViewControllerAnimated(true)
    }

    // UIImagePickerControllerDelegate Methods
    func uzysAssetsPickerController(picker: UzysAssetsPickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        
        self.photoPreviewHeight?.constant = 60
        self.photoPreviewTopSpace?.constant = 22
        var assetsArray = (assets as Array<ALAsset>)
        
        photoUrlArray = DataManager.saveImages(assetsArray)
        
        //Set preview
        var imageArray: Array<UIImage> = []
        for url in photoUrlArray! {
            var image = DataManager.getImageFromUrl(url)
            imageArray.append(image)
        }
        photoPreviewView?.frame = CGRectMake((photoPreviewView?.frame.origin.x)!, (photoPreviewView?.frame.origin.y)!, (photoPreviewView?.frame.size.width)!, 60)
        photoPreviewView?.preferredImageOffset = 40
        photoPreviewView?.imageArray = imageArray
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
    }
}