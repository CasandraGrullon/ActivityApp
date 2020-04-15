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

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupImageView()
    }
    
    private func setupImageView() {
        addSubview(wantedPoster)
        wantedPoster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wantedPoster.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wantedPoster.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            wantedPoster.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            wantedPoster.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        
    }
}
