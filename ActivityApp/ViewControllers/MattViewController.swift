//
//  ActivityViewController.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class MattViewController: UIViewController {
    
    let mattView = MattView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mattView.backgroundColor = .systemTeal
        view = mattView
    }
    
 

    private func sepiaFilter(image: UIImage, value: Double) -> CIImage? {
        
        let tempImage = CIImage(cgImage: image.cgImage!)
        let sepiaFilter = CIFilter(name:"CISepiaTone")
        sepiaFilter?.setValue(tempImage, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(value, forKey: kCIInputIntensityKey)
        return sepiaFilter?.outputImage
    }
    
}
