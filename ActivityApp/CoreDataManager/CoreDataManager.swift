//
//  CoreDataManager.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    private init() {}
    static let shared = CoreDataManager()
    private var mediaObjects = [MediaObject]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func createMediaObject(_ imageData: Data, videoURL: URL?, caption: String?, activityName: String) -> MediaObject {
        let mediaObject = MediaObject(entity: MediaObject.entity(), insertInto: context)
        mediaObject.id = UUID().uuidString
        mediaObject.createdDate = Date()
        mediaObject.imageData = imageData
        mediaObject.activityName = activityName
        
        if let caption = caption {
            mediaObject.caption = caption
        }
        
        if let videoURL = videoURL {
            do {
                mediaObject.videoData = try Data(contentsOf: videoURL)
            } catch {
                print("failed to convert video url to data \(error.localizedDescription)")
                
            }
        }
        
        do {
            try context.save()
        } catch {
            print("failed to save media object \(error.localizedDescription)")
            
        }
        return mediaObject
    }
    
    public func fetchAllMediaObject() -> [MediaObject] {
        do {
            mediaObjects = try context.fetch(MediaObject.fetchRequest())
        } catch {
            print("failed to fetch media objects \(error.localizedDescription)")
        }
        return mediaObjects
    }
    
    
    @discardableResult
    public func deleteObject(_ object: MediaObject) -> Bool {
        var wasDeleted = false
        context.delete(object)
        do {
            try context.save()
            wasDeleted = true
        } catch {
            print("failed to delete object with error: \(error)")
        }
        return wasDeleted
    }
    
}
