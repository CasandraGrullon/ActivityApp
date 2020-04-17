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
        interviewView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
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
        configureButtons()
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            interviewView.cameraButton.isEnabled = false
        }
        fetchMediaObjects()
    }
    
    private func fetchMediaObjects() {
        mediaObjects = CoreDataManager.shared.fetchAllMediaObject().filter {$0.activityName == activity?.activityName}
    }
    
    private func configureCollectionView() {
        interviewView.collectionView.delegate = self
        interviewView.collectionView.dataSource = self
        interviewView.collectionView.register(InterviewCell.self, forCellWithReuseIdentifier: "interviewCell")
    }
    private func configureButtons() {
        interviewView.cameraButton.addTarget(self, action: #selector(videoButtonPressed(_:)), for: .touchUpInside)
        interviewView.galleryButton.addTarget(self, action: #selector(photoGalleryButtonPressed(_:)), for: .touchUpInside)
    }
    @objc private func photoGalleryButtonPressed(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    @objc private func videoButtonPressed(_ sender: UIButton) {
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
    }
    
}
extension CasandraViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
extension CasandraViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = interviewView.collectionView.dequeueReusableCell(withReuseIdentifier: "interviewCell", for: indexPath) as? InterviewCell else {
            fatalError("could not cast to interview cell")
        }
        let mediaObject = mediaObjects[indexPath.row]
        cell.configureCell(media: mediaObject)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mediaObject = mediaObjects[indexPath.row]
        guard let mediaURL = mediaObject.videoData?.convertToURL() else {return}
        let playerVC = AVPlayerViewController()
        let player = AVPlayer(url: mediaURL)
        playerVC.player = player
        present(playerVC, animated: true) {
            player.play()
        }
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
