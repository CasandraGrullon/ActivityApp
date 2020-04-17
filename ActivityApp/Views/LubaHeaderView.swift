//
//  LubaHeaderView.swift
//  ActivityApp
//
//  Created by casandra grullon on 4/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class LubaHeaderView: UICollectionReusableView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.clipsToBounds = true
        headerLabel.layer.cornerRadius = 13
    }
        
        public lazy var headerLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5091376901, blue: 0.4806880355, alpha: 1)
            label.textColor = .systemOrange
            label.text = "Directions"
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            return label
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
            setupHeaderLabelConstraints()
            
        }

        private func setupHeaderLabelConstraints() {
            addSubview(headerLabel)
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ])
        }
}

