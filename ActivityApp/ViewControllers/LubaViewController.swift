//
//  ActivityTwoViewController.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class LubaViewController: UIViewController {

   private let lubaView = LubaView()
        
        override func loadView() {
            view = lubaView
        }
        
        private lazy var imagePickerController: UIImagePickerController = {
            // photo and video
            let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)
            let pickerController = UIImagePickerController()
            
            pickerController.mediaTypes = mediaTypes ?? ["kUTTypeImage"]
            pickerController.delegate = self
            return pickerController
        }()
        
        
        // here change String to Object that we will create
        private var mediaObjects = [MediaObject]() {
            didSet{
                lubaView.collectionView.reloadData()
            }
        }
    
    public var activity: Activity?
        
        override func viewDidLoad() {
            super.viewDidLoad()

            lubaView.backgroundColor = #colorLiteral(red: 1, green: 0.7233033776, blue: 0.2232708037, alpha: 1)
            navigationItem.title = "Name of the activity"
            configureCellAndHeader()
            configureCollectionView()
            configureAddButton()
            fetchMediaObjects()
        }
    
    private func fetchMediaObjects() {
        mediaObjects = CoreDataManager.shared.fetchAllMediaObject()//.filter { $0.activityName == activity?.activityName}

    }
    
    private func configureCollectionView() {
        lubaView.collectionView.dataSource = self
        lubaView.collectionView.delegate = self
    }
    public func configureCellAndHeader() {
        lubaView.collectionView.register(LubaCell.self, forCellWithReuseIdentifier: "lubaCell")
        lubaView.collectionView.register(LubaHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
    }
    public func configureAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonPressed(_:)))
    }
        
        @objc private func addButtonPressed(_ sender: UIBarButtonItem) {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let addFromLibararyAction = UIAlertAction(title: "Go to Libarary", style: .default) { [weak self](alertAction) in
                self?.showImageController(isCameraSelected: false)
               // self?.imagePickerController.sourceType = .photoLibrary
                //self?.present(self!.imagePickerController, animated: true)
            }
            let accessCameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self](alertAction) in
                self?.showImageController(isCameraSelected: true)
               // self?.imagePickerController.sourceType = .camera
               // self?.present(self!.imagePickerController, animated: true)
            }
            alertController.addAction(addFromLibararyAction)
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(accessCameraAction)
            }
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true)
            
        }
    private func showImageController(isCameraSelected: Bool) {
           // source type default will be .photoLibrary
           imagePickerController.sourceType = .photoLibrary
           
           if isCameraSelected {
               imagePickerController.sourceType = .camera
           }
           present(imagePickerController, animated: true)
       }
       


    }

    extension LubaViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return mediaObjects.count        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lubaCell", for: indexPath) as? LubaCell else {
                fatalError("could not downcast to LubaCell")
            }
            cell.delegate = self
            let object = mediaObjects[indexPath.row]
            cell.configureCell(for: object)
            cell.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            let rawCounter = indexPath.row + 1
            cell.stepsLabel.text = "Step \(rawCounter)"
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as? LubaHeaderView else {
                fatalError("could not dequeue a HeaderView")
            }
            
            return headerView
        }
    }

    extension LubaViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.30)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let mediaObject = mediaObjects[indexPath.row]
            guard let videoURL = mediaObject.videoData?.convertToURL() else { return}
        
        let playerViewController = AVPlayerViewController()
            let player = AVPlayer(url: videoURL)
            playerViewController.player = player
            present(playerViewController, animated: true)
            player.play()
        }
    }

    extension LubaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {
                return
            }
            switch mediaType {
            case "public.image":
                
                if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imageData = originalImage.jpegData(compressionQuality: 1.0), let activity = activity?.activityName {
                    //let mediaObject = MediaObject(imageData: imageData, videoURL: nil, caption: nil)
                    let mediaObject = CoreDataManager.shared.createMediaObject(imageData, videoURL: nil, caption: nil, activityName: activity)
                    mediaObjects.append(mediaObject)
                }
            case "public.movie":
                if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL, let image = mediaURL.videoPreviewThumbnail(), let imageData = image.jpegData(compressionQuality: 1.0), let activity = activity?.activityName {
                    //let mediaObject = MediaObject(imageData: nil, videoURL: mediaURL, caption: nil)
                    let mediaObject = CoreDataManager.shared.createMediaObject(imageData, videoURL: mediaURL, caption: nil, activityName: activity)
                    mediaObjects.append(mediaObject)
                }
            default:
                print("Unsupported media type")
            }
            picker.dismiss(animated: true)
            
        }
}

extension LubaViewController: LubaCellDelegate {
    func didLongPress(_ lubaCell: LubaCell) {
        print("cell was selected")
        guard let indexPath = lubaView.collectionView.indexPath(for: lubaCell) else {
            return
        }
        let alertController = UIAlertController(title: nil, message: "Delete and add something new?:)", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (alertAction) in
            self?.deleteObject(indxPath: indexPath)
        }
        //TODO: add edit function
        let editAction = UIAlertAction(title: "Edit", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(editAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    private func deleteObject(indxPath: IndexPath) {
        //do {
             mediaObjects.remove(at: indxPath.row)
           // lubaView.collectionView.deleteItems(at: [indxPath])
       // } catch {
          //  print("error deleting object: \(error)")
        //}
    }
    
    
}

