//
//  InterviewCell.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class InterviewCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
    }
    public lazy var videoThumbnail: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        imageConstraints()
    }
    private func imageConstraints() {
        addSubview(videoThumbnail)
        videoThumbnail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoThumbnail.topAnchor.constraint(equalTo: topAnchor),
            videoThumbnail.bottomAnchor.constraint(equalTo: bottomAnchor),
            videoThumbnail.leadingAnchor.constraint(equalTo: leadingAnchor),
            videoThumbnail.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    public func configureCell(media: MediaObject) {
        if let imageData = media.imageData  {
            videoThumbnail.image = UIImage(data: imageData)
        }
        if let videoURL = media.videoData?.convertToURL() {
            let image = videoURL.videoPreviewThumbnail() ?? UIImage(systemName: "video")
            videoThumbnail.image = image
        }
    }
}
