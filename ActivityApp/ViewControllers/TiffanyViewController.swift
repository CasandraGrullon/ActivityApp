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
    private var selectedImage: UIImage? {
        didSet {
            doodleView.imageView.image = selectedImage
        }
    }
    
    
    private lazy var imagePickerController: UIImagePickerController = {
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)
        
        let picker = UIImagePickerController()
        
        picker.mediaTypes = mediaTypes ?? ["kUTTypeImage"]
        picker.delegate = self
        
        return picker
        
    }()
    
    private var mediaObjects = [MediaObject]() {
        didSet{
            doodleView.collectionView.reloadData()
        }
    }
    
    public var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = doodleView
        doodleView.imageView.image = UIImage(named: "basket")
        view.backgroundColor = .black
        doodleView.collectionView.register(InterviewCell.self, forCellWithReuseIdentifier: "interviewCell")
        cameraButtonPressed()
        photoLibraryButtonPressed()
        takeScreenShotOfView()
        getRandomImageButtonPressed()
        clearDoodleView()
        setUpCollectionView()
        fetchSavedScreenshots()
    }
    
    private func cameraButtonPressed(){
        doodleView.cameraButton.addTarget(self, action: #selector(showCameraOption), for: .touchUpInside)
    }
    
    private func photoLibraryButtonPressed(){
        doodleView.libraryButton.addTarget(self, action: #selector(showPhotoLibraryOption), for: .touchUpInside)
    }
    
    private func getRandomImageButtonPressed(){
        doodleView.randomPhotoButton.addTarget(self, action: #selector(generateRandomPhoto), for: .touchUpInside)
    }
    
    private func takeScreenShotOfView(){
        doodleView.saveButton.addTarget(self, action: #selector(getScreetschot), for: .touchUpInside)
    }
    private func clearDoodleView(){
        doodleView.clearButton.addTarget(self, action: #selector(clearScreen), for: .touchUpInside)
    }
    private func setUpCollectionView(){
    doodleView.collectionView.dataSource = self
        doodleView.collectionView.delegate = self
    
    }
    private func fetchSavedScreenshots(){
        mediaObjects = CoreDataManager.shared.fetchAllMediaObject().filter{$0.activityName == activity?.activityName}
    }
    
   @objc private func showCameraOption(){
    clearScreen()
        let alertController = UIAlertController(title: "Take Photo", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated:  true)
    }
    
   @objc private func showPhotoLibraryOption() {
        clearScreen()
        let alertController = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .actionSheet)
        
            let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (alertAction) in
                self.imagePickerController.sourceType = .photoLibrary
                self.present(self.imagePickerController, animated: true)

        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alertController.addAction(photoLibrary)
        alertController.addAction(cancelAction)
        
        present(alertController, animated:  true)
    }
    
    @objc private func generateRandomPhoto(){
        clearScreen()
        let arrayOfImages = [UIImage(named: "basket"), UIImage(named: "dog"),UIImage(named: "bingo"),UIImage(named: "icecream"),UIImage(named: "jellyfish"),UIImage(named: "kidCanvas"),UIImage(named: "newgrid")]
        
        if let randomImage = arrayOfImages.randomElement() {
            selectedImage = randomImage
        }
    }
    
   @objc private func getScreetschot(){
    
    var success: Bool!
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: view.frame.size.width, height: view.frame.size.height * 0.70), true, 0)
    guard let context = UIGraphicsGetCurrentContext() else { return }
    view.layer.render(in: context)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
        success = false
        return }
    UIGraphicsEndImageContext()
    
    //save to coreData
    
    guard let imageData = image.jpegData(compressionQuality: 1.0) else {return}
    
    saveScreenShotToCoreData(with: imageData)
    

    //Save it to the camera roll
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    success = true
    
    if success {
        self.showAlert(title: "Saved To Camera Roll", message: nil)
    } else {
        self.showAlert(title: "Could Not Save Image", message: "Please Try again later.")
    }
    

    }
    
    @objc private func clearScreen(){
        doodleView.doodleView.clearStrokes()
        
    }
    
    private func saveScreenShotToCoreData(with imageData: Data){
        
        if let activityName = activity?.activityName {
            let mediaObject = CoreDataManager.shared.createMediaObject(imageData, videoURL: nil, caption: nil, activityName: activityName)
            
            mediaObjects.append(mediaObject)
        }
    
    }
}
extension TiffanyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        
        selectedImage = image
        dismiss(animated: true, completion: nil)
        
    }
}

extension UIViewController {
    public func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
    
        present(alertController, animated: true)
    }

}

extension TiffanyViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mediaObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interviewCell", for: indexPath) as? InterviewCell else {
            fatalError("could not downcast to InterviewCell")
        }
        let image = mediaObjects[indexPath.row]
        cell.configureCell(media: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: 100, height: 100)
    }
    
}
