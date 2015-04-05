//
//  EventCell.swift
//  PhotoCloud-EventManager
//
//  Created by Sally Yang Jing Ou on 2015-03-14.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol EventCellDelegate : class {
    func eventCell(eventCell:EventCell, willDeleteEvent event : NSManagedObject)
}

class EventCell: UICollectionViewCell {
    @IBOutlet weak var eventImageView: UIImageView?
    @IBOutlet weak var eventNameLabel: UILabel?
    @IBOutlet weak var eventDateLabel: UILabel?
    @IBOutlet weak var deleteEventButton: UIButton?
    
    var eventObject : NSManagedObject? = nil
    weak var delegate : EventCellDelegate? = nil

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressAction:")
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @IBAction func deleteEvent(sender: UIButton!) {
        if((eventObject) != nil){
            if((delegate) != nil){
                delegate?.eventCell(self, willDeleteEvent: eventObject!)
            }
        }
    }
    
    func longPressAction(recognizer : UILongPressGestureRecognizer){
        if(recognizer.state == UIGestureRecognizerState.Ended){
            if((eventObject) != nil){
                if((delegate) != nil){
                    delegate?.eventCell(self, willDeleteEvent: eventObject!)
                }
            }
        }
    }
}