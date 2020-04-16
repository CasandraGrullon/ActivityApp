//
//  CasandraView.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class CasandraView: UIView {
    
    public lazy var questionsLabel: UILabel = {
    let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Interview Questions\n1. What/who is your biggest inspiration?\n2. What do you want to be when you grow up?\n3. What is your favorite color?\n4. What is the last movie you saw?"
        return label
        
    }()
    public lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cameraButton, galleryButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    public lazy var cameraButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "video.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return button
    }()
    public lazy var galleryButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "photo.on.rectangle.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return button
    }()
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return cv
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
        configureLabelConstraints()
        configureButtonStack()
        configureCollectionViewConstraints()
    }

    private func configureLabelConstraints() {
        addSubview(questionsLabel)
        questionsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            questionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            questionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    private func configureButtonStack() {
        addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: questionsLabel.bottomAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonStack.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func configureCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
}
