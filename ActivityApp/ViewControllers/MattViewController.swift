//
//  ActivityViewController.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

enum Theme {
    case poster
    case paper
}

class MattViewController: UIViewController {
    
    let mattView = MattView()
    let themeButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(themeButtonPressed))
    private var imagePickerController = UIImagePickerController()
    private var currentTheme: Theme = .poster
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mattView.backgroundColor = .systemTeal
        mattView.photoButton.addTarget(self, action: #selector(photoButtonPressed), for: .allEvents)
        mattView.themeButton.addTarget(self, action: #selector(themeButtonPressed), for: .allEvents)
        view = mattView
        navigationController?.navigationItem.rightBarButtonItem = themeButton
        imagePickerController.delegate = self
        
    }
    
    private func sepiaFilter(image: UIImage, value: Double) -> CIImage? {
        
        let tempImage = CIImage(cgImage: image.cgImage!)
        let sepiaFilter = CIFilter(name:"CISepiaTone")
        sepiaFilter?.setValue(tempImage, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(value, forKey: kCIInputIntensityKey)
        return sepiaFilter?.outputImage
    }
    
    @objc
    func themeButtonPressed () {
        switch currentTheme {
        case .poster:
            UIView.transition(with: mattView, duration: 2, options: [.transitionCrossDissolve], animations: {
                self.mattView.templateImageView.image = UIImage(named: "agingPaper")
            }, completion: nil)
            currentTheme = .paper
            
        case .paper:
            UIView.transition(with: mattView, duration: 2, options: [.transitionCrossDissolve], animations: {
                self.mattView.templateImageView.image = UIImage(named: "wantedPoster")
            }, completion: nil)
            currentTheme = .poster
        }
    }
    
    @objc
    func photoButtonPressed () {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
}

extension MattViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            showAlert(title: "Error", message: "Image was not found")
            return
        }
        mattView.photoImageView.image = image
    }
}
