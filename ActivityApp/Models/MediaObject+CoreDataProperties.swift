//
//  MediaObject+CoreDataProperties.swift
//  ActivityApp
//
//  Created by Liubov Kaper  on 4/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//
//

import Foundation
import CoreData


extension MediaObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaObject> {
        return NSFetchRequest<MediaObject>(entityName: "MediaObject")
    }

    @NSManaged public var activityName: String?
    @NSManaged public var caption: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var id: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var videoData: Data?

}
