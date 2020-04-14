//
//  ActivitiesCollectionView.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ActivitiesCollectionView: UIView {
    public lazy var appNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Fun Activities"
        label.textAlignment = .center
        return label
    }()
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
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
        labelConstraints()
        collectionViewConstraints()
    }
    private func labelConstraints() {
        addSubview(appNameLabel)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            appNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            appNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
    private func collectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: -20)
        ])
    }

}
