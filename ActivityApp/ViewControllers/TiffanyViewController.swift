//
//  ActivityThreeViewController.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class TiffanyViewController: UIViewController {

    let doodleView = TiffanyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = doodleView
        doodleView.imageView.image = UIImage(named: "newgrid")
        view.backgroundColor = .black
        
        
    }
    

    
    func getScreetschot(){
    UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0)
    guard let context = UIGraphicsGetCurrentContext() else { return }
    view.layer.render(in: context)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
    UIGraphicsEndImageContext()

    //Save it to the camera roll
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

}
}
