//
//  ActivityFourViewController.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import AVKit

class CasandraViewController: UIViewController {
    
    private let interviewView = CasandraView()
    
    override func loadView() {
        view = interviewView
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)
        let pickerController = UIImagePickerController()
        pickerController.mediaTypes = mediaTypes ?? ["kUTTypeImage"]
        pickerController.delegate = self
        return pickerController
    }()
    public var activity: Activity?
    private var mediaObjects = [MediaObject]() {
        didSet {
            interviewView.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = activity?.activityName
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        interviewView.collectionView.delegate = self
        interviewView.collectionView.dataSource = self
    }
    
}
extension CasandraViewController: UICollectionViewDelegateFlowLayout {
    
}
extension CasandraViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = interviewView.collectionView.dequeueReusableCell(withReuseIdentifier: "interviewCell", for: indexPath) as? InterviewCell else {
            fatalError("could not cast to interview cell")
        }
        return cell
    }
    
    
}
extension CasandraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {
                return
            }
        switch mediaType {
        case "public.movie":
            if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
                let image = mediaURL.videoPreviewThumbnail(),
                let imageData = image.jpegData(compressionQuality: 1.0),
                let activityName = activity?.activityName {
                let mediaObject = CoreDataManager.shared.createMediaObject(imageData, videoURL: mediaURL, caption: nil, activityName: activityName)
                mediaObjects.append(mediaObject)
            }
        default:
        showAlert(title: "Unsupported media type", message: "Only videos are accepted.")
    }
        picker.dismiss(animated: true)
    }
}
