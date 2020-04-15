//
//  ActivitiesCollectionView.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ActivitiesCollectionView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 13
    }
    public lazy var appNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Fun Activities"
        label.font = UIFont(name: "Helvetica", size: 40)
        label.textColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
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
            appNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            appNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            appNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
    private func collectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

}
