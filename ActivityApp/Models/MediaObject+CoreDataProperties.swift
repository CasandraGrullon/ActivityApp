//
//  MediaObject+CoreDataProperties.swift
//  
//
//  Created by casandra grullon on 4/15/20.
//
//

import Foundation
import CoreData


extension MediaObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaObject> {
        return NSFetchRequest<MediaObject>(entityName: "MediaObject")
    }

    @NSManaged public var caption: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var id: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var videoData: Data?

}
