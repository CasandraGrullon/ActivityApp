//
//  MattView.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class MattView: UIView {
    
    public lazy var templateImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "wantedPoster")
        return iv
    }()
    
    public lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person")
        iv.tintColor = .systemOrange
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    public lazy var photoButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "camera.fill"), for: .normal)
        return button
    }()
    
    public lazy var themeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Theme", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
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
        setupPosterView()
        setupPhotoView()
        setupPhotoButton()
        setupThemeButton()
    }
    
    private func setupPosterView() {
        addSubview(templateImageView)
        templateImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            templateImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            templateImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            templateImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            templateImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    private func setupPhotoView() {
        addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: templateImageView.centerXAnchor, constant: -7),
            photoImageView.centerYAnchor.constraint(equalTo: templateImageView.centerYAnchor, constant: 15),
            photoImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.45),
            photoImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.62)
        ])
    }
    
    private func setupPhotoButton() {
        addSubview(photoButton)
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            photoButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            photoButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.06),
            photoButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.15)
        
        ])
    }
    
    private func setupThemeButton() {
        addSubview(themeButton)
        themeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            themeButton.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            themeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
                    
        ])
    }
}
