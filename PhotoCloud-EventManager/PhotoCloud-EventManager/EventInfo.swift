//
//  EventInfo.swift
//  PhotoCloud-EventManager
//
//  Created by Negin Hodaie on 2015-03-15.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import CoreData

@objc(EventInfo)

class EventInfo: NSManagedObject{
    @NSManaged var createDate: NSDate
    @NSManaged var eventDate: NSDate
    @NSManaged var name: String
    @NSManaged var location: EventLocation
    @NSManaged var photos: NSData
}