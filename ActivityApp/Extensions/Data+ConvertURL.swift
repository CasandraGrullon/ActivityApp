//
//  Data+ConvertURL.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/15/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

extension Data {
    
    public func convertToURL() -> URL? {

        
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("video").appendingPathExtension("mp4")
        
        do {
            try self.write(to: tempURL, options: [.atomic]) 
            return tempURL
        } catch {
            print("failed to write video data to temporary file with error \(error.localizedDescription)")
        }
        return nil
    }
}
