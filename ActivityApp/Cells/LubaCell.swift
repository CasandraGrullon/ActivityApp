//
//  LubaCell.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

protocol LubaCellDelegate: AnyObject {
    func didLongPress(_ lubaCell: LubaCell)
}

class LubaCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        actionImage.clipsToBounds = true
        actionImage.layer.cornerRadius = 13
        stepsLabel.clipsToBounds = true
        stepsLabel.layer.cornerRadius = 13
    }
    
    weak var delegate: LubaCellDelegate?
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()
    @objc private func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.state = .cancelled
            return
        }
        delegate?.didLongPress(self)
    }
     public lazy var actionImage: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(systemName: "person.fill")
            image.backgroundColor = .systemBackground
            image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
            image.addGestureRecognizer(longPressGesture)
        
            return image
        }()
        
        public lazy var stepsLabel: UILabel = {
               let label = UILabel()
               label.backgroundColor = #colorLiteral(red: 0.929641068, green: 0.8683214784, blue: 0, alpha: 0.7392176798)
            label.textColor = .systemBlue
               label.text = "Step 1"
               label.numberOfLines = 0
               label.textAlignment = .center
               label.font = UIFont.preferredFont(forTextStyle: .headline)
               return label
           }()
        
        public lazy var addMediaButton: UIButton = {
            let button = UIButton()
            button.tintColor = .systemGray
            button.setImage(UIImage(systemName: "photo.fill"), for: .normal)
            //let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .black, scale: .large)
           // button.setImage(UIImage(systemName: "ellipsis", withConfiguration: imageConfig), for: .normal)
           // button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
            
            return button
        }()
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            setUpStepLabelConstraints()
            setUpActionImageConstraints()
            
            
            //setupMoreButtonConstraints()
        }
        
        
        private func setUpActionImageConstraints(){
            addSubview(actionImage)
            actionImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                actionImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                actionImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                actionImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                actionImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75)
            ])
        }
    
    private func setUpStepLabelConstraints() {
        addSubview(stepsLabel)
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stepsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stepsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            stepsLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10)
        ])
    }
    
    public func configureCell(for mediaObject: MediaObject) {
        if let imageData = mediaObject.imageData {
            actionImage.image = UIImage(data: imageData)
        }
        if let videoData = mediaObject.videoData, let videoURL = videoData.convertToURL() {
            let image = videoURL.videoPreviewThumbnail() ?? UIImage(systemName: "heart")
            actionImage.image = image
        }
    }
        
    }




