//
//  DatabaseService.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import FirebaseFirestore

private let db = Firestore.firestore()
class DatabaseService {
    
    private init() {}
    public static let shared = DatabaseService()
    
    public func getActivities(completion: @escaping (Result<[Activity], Error>) -> ()) {
        db.collection("activities").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let activities = snapshot.documents.compactMap {Activity ($0.data())}
                completion(.success(activities))
            }
        }
    }
}
