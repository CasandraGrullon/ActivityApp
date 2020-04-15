//
//  ActivitiesCell.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ActivitiesCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
        activityNameLabel.clipsToBounds = true
    }
    
    public lazy var activityNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        label.numberOfLines = 0
        return label
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
        labelConstraints()
    }
    private func labelConstraints() {
        addSubview(activityNameLabel)
        activityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            activityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
