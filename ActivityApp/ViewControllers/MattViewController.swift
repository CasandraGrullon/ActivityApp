//
//  ActivityViewController.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//
import UIKit

enum Theme {
    case paper
    case poster
    case hollywood
}

class MattViewController: UIViewController {
    
    let mattView = MattView()
    private var imagePickerController = UIImagePickerController()
    private var mediaObjects = [MediaObject]()
    public var activity: Activity?
    private var currentTheme: Theme = .paper
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mattView.backgroundColor = .systemTeal
        mattView.photoButton.addTarget(self, action: #selector(photoButtonPressed), for: .touchUpInside)
        mattView.themeButton.addTarget(self, action: #selector(themeButtonPressed), for: .touchUpInside)
        view = mattView
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
            
            
        case .paper:
            UIView.transition(with: mattView, duration: 1, options: [.transitionFlipFromRight], animations: {
                self.mattView.templateImageView.image = UIImage(named: "wantedPoster")
            }, completion: nil)
            currentTheme = .poster
            
        case .poster:
            UIView.transition(with: mattView, duration: 1, options: [.transitionCurlUp], animations: {
                self.mattView.templateImageView.image = UIImage(named: "hollywood")
            }, completion: nil)
            currentTheme = .hollywood
            
        case .hollywood:
            UIView.transition(with: mattView, duration: 1, options: [.transitionCrossDissolve], animations: {
                self.mattView.templateImageView.image = UIImage(named: "agingPaper")
            }, completion: nil)
            currentTheme = .paper
            
        }
    }
    
    @objc
    func photoButtonPressed () {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] (alertAction) in
            self?.showImageController(isCameraSelected: false)
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (alertAction) in
            self?.showImageController(isCameraSelected: true)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        alertController.addAction(cameraAction)
        }
        
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc
    func saveButtonPressed() {
        if let imageData = mattView.photoImageView.image!.jpegData(compressionQuality: 1.0), let activity = activity?.activityName {
            let mediaObject = CoreDataManager.shared.createMediaObject(imageData, videoURL: nil, caption: nil, activityName: activity)
            mediaObjects.append(mediaObject)
        }
        
        showAlert(title: "Success", message: "Photo Saved to Collection")
    }
    
    private func showImageController(isCameraSelected: Bool) {
        
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        present(imagePickerController, animated: true)
    }
}

extension MattViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            showAlert(title: "Error", message: "Image was not found")
            return
        }
        let ciimage = sepiaFilter(image: image, value: 1.0)
        mattView.photoImageView.image = UIImage(ciImage: ciimage!)
        dismiss(animated: true)
    }
}
