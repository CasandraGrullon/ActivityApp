//
//  Activities.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct Activity {
    let activityName: String
    let activityRules: String
    let id: String
}
extension Activity {
    init?(_ dictionary: [String: Any]) {
        guard let activityName = dictionary["activityName"] as? String,
        let activityRules = dictionary["activityRules"] as? String,
            let id = dictionary["id"] as? String else {
                return nil
        }
        self.activityName = activityName
        self.activityRules = activityRules
        self.id = id
    }
}
