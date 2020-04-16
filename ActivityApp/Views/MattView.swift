//
//  MattView.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class MattView: UIView {
    
    public lazy var wantedPoster: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "wantedPoster")
        return iv
    }()
    
    public lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemTeal
        return iv
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
        setupPosterView()
        setupPhotoView()
    }
    
    private func setupPosterView() {
        addSubview(wantedPoster)
        wantedPoster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wantedPoster.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wantedPoster.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            wantedPoster.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            wantedPoster.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    private func setupPhotoView() {
        addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: wantedPoster.centerXAnchor, constant: -7),
            photoImageView.centerYAnchor.constraint(equalTo: wantedPoster.centerYAnchor, constant: 15),
            photoImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.45),
            photoImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.62)
        ])
    }
}
