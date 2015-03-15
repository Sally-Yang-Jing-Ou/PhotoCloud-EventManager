//
//  EventLocation.swift
//  PhotoCloud-EventManager
//
//  Created by Negin Hodaie on 2015-03-15.
//  Copyright (c) 2015 Sally Yang Jing Ou. All rights reserved.
//

import Foundation
import CoreData

@objc(EventLocation)

class EventLocation: NSManagedObject{
    @NSManaged var latitude: Float
    @NSManaged var longitude: Float
}