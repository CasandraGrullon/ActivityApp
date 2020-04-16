//
//  URL+VideoPreviewThumbnail.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import AVFoundation

extension URL {
    public func videoPreviewThumbnail() -> UIImage? {
        let asset = AVAsset(url: self)
        
        let assetGenerator = AVAssetImageGenerator(asset: asset)
        
        assetGenerator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        var image: UIImage?
        
        do {
            let cgImage = try assetGenerator.copyCGImage(at: timestamp, actualTime: nil)
            image = UIImage(cgImage: cgImage)
        } catch {
            print("failed to generate image \(error.localizedDescription)")
        }
        
        return image
        
    }
}
